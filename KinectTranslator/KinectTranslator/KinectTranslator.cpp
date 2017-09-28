#include <iostream>
#include <sstream>
#include<string>
#include <Kinect.h>
#include <opencv2\opencv.hpp>
#include "ComPtr.h"

using namespace std;
using namespace cv;
//SVM Classification icin olusturulmus nesneler
CvSVM svm, svm1, svm2, svm3;

//runtime da olusan hataları yakalıyo
#define ERROR_CHECK( ret )  \
    if ( (ret) != S_OK ) {    \
        std::stringstream ss;	\
        ss << "failed " #ret " " << std::hex << ret << std::endl;			\
        throw std::runtime_error( ss.str().c_str() );			\
		    }

class KinectApp
{
private:

	IKinectSensor* kinect = nullptr;
	int thresh = 100;
	IDepthFrameReader* depthFrameReader = nullptr;
	std::vector<UINT16> depthBuffer;

	const char* DepthWindowName = "Depth Image";

	int m = 0;
	UINT16 minDepthReliableDistance;
	UINT16 maxDepthReliableDistance;

	int depthWidth;
	int depthHeight;

	int depthPointX;
	int depthPointY;
	int d;
public:

	
	void initialize()
	{
		
		ERROR_CHECK(::GetDefaultKinectSensor(&kinect));

		
		ERROR_CHECK(kinect->Open());

		BOOLEAN isOpen = false;
		ERROR_CHECK(kinect->get_IsOpen(&isOpen));
		if (!isOpen){
			throw std::runtime_error("Kinect does  not open ");
		}

		
		ComPtr<IDepthFrameSource> depthFrameSource;
		ERROR_CHECK(kinect->get_DepthFrameSource(&depthFrameSource));
		ERROR_CHECK(depthFrameSource->OpenReader(&depthFrameReader));

		
		ComPtr<IFrameDescription> depthFrameDescription;
		ERROR_CHECK(depthFrameSource->get_FrameDescription(&depthFrameDescription));
		ERROR_CHECK(depthFrameDescription->get_Width(&depthWidth));
		ERROR_CHECK(depthFrameDescription->get_Height(&depthHeight));

		depthPointX = depthWidth / 2;
		depthPointY = depthHeight / 2;

		
		//Derinlik maksimum değeri, minimum değeri elde etmek için
		ERROR_CHECK(depthFrameSource->get_DepthMinReliableDistance(&minDepthReliableDistance));
		ERROR_CHECK(depthFrameSource->get_DepthMaxReliableDistance(&maxDepthReliableDistance));

		

		std::cout << "Depth Min       : " << minDepthReliableDistance << std::endl;
		std::cout << "Depth Max       : " << maxDepthReliableDistance << std::endl;

		
		//depthBuffer bir tampon oluşturmak için alınan depth görüntüsüdür. 
		//Kinectten alınan depth verisi 16 bittir ve bu veri unsigned 16-bit integer tipindeki depthBuffera yazdırıldı. 
		
		//depthBufferin size'ı kinectten gelen veriye göre ayarlanır.
		depthBuffer.resize(depthWidth * depthHeight);

	
		
		cv::namedWindow(DepthWindowName);
		
	}

	void run()
	{
		while (1) {
			update();
			draw();

			auto key = cv::waitKey(10);
			if (key == 'q'){
				break;
			}
		}
	}

private:

	//Veri güncelleme işleme
	void update()
	{
		updateDepthFrame();
	}

	void updateDepthFrame()
	{
		//Derinlik frame almak için
		ComPtr<IDepthFrame> depthFrame;
		auto ret = depthFrameReader->AcquireLatestFrame(&depthFrame);
		if (ret != S_OK){
			return;
		}

		//error yakalanmazsa kinectten gelen görüntü depthBuffera atılıyor.
		ERROR_CHECK(depthFrame->CopyFrameDataToArray(depthBuffer.size(), &depthBuffer[0]));
	}

	void draw()
	{
		drawDepthFrame();
	}

	void drawDepthFrame()
	{
		//Derinlik verilerini görüntülemek için
		cv::Mat depthImage(depthHeight, depthWidth, CV_8UC1);
		
		//0-255 gri verilere Derinlik verileri
		int colorIndex = 0;
		//0-255 gri verilere Derinlik verileri
		for (int i = 0; i < depthImage.total(); ++i){
			ushort depth = depthBuffer[i];

			//Görüntünün daha iyi olması icin Min-Max Normalizasyonu
			//Böylece bütün pixel degerleri 0-255 arasına cekiliyor. Böylece algılanamayan uzaklıklara da deger atanmıs oluyor.
			ushort intensity = (ushort)(depth >= minDepthReliableDistance && depth <= maxDepthReliableDistance ? depth : 0);
			int converted = 0;
			converted = (int)(255 * (1.0 * intensity - minDepthReliableDistance) / (maxDepthReliableDistance - minDepthReliableDistance));//Min-Max Normalization
			//Belirli bir degeri al.Threshold yani.
			if (intensity > 0 && converted < 25)
			{
				depthImage.data[colorIndex++] = (byte)(converted); // Gray

			}
			else
			{
				depthImage.data[colorIndex++] = (byte)255; 

			}
		}

		Mat threshold_output;
		vector<vector<Point> > contours;
		vector<Vec4i> hierarchy;
		/// Burada resimdeki irrelevant yerler atılmaya calısıldı.
	    /// İlk olarak elin kenarları threshold degeri kullanılarak belirlendi
		threshold(depthImage, threshold_output, thresh, 255, THRESH_BINARY);
		//Sonra etraflar bulunmus oldu. Yani resimin contour'u bulundu
		findContours(threshold_output, contours, hierarchy, RETR_TREE, CHAIN_APPROX_SIMPLE, Point(0, 0));
		Mat resizingImage;
		Size size(200, 200);
		char FullFileName[100];
		char FirstFileName[100] = "D:\\Kinect\\Derinlik2\\dt-";
		/// Yaklasık etraf bulunmus oldu .
		vector<vector<Point> > contours_poly(contours.size());
		vector<Rect> boundRect(contours.size());
		vector<Point2f>center(contours.size());
		vector<float>radius(contours.size());
		Mat newImage;

		int q = 0, r = 0;
		for (size_t i = 0; i < contours.size(); i++)
		{
			approxPolyDP(Mat(contours[i]), contours_poly[i], 3, true);
			boundRect[i] = boundingRect(Mat(contours_poly[i]));
			minEnclosingCircle(contours_poly[i], center[i], radius[i]);
			//Bu for dongusuylede region of interest mantıgıyla bulunan seklın etrafına göre resim küçültülmüş oldu
			//yeni resim newImage'e atıldı
			newImage = depthImage(Rect(boundRect[i].x, boundRect[i].y, boundRect[i].width, boundRect[i].height));
		}
		m++;
		resize(newImage, resizingImage, size);//resizing yapılarak
		//Etrafları çıkarılmış yani sadece el görüntüsü olan frame 200*200 luk seklinde kücültüldü
		sprintf_s(FullFileName, "%s%d.png", FirstFileName, m);//Son olarak ta bu resimi training sette kullanılmak üzere diske kaydedildi.
		imwrite(FullFileName, resizingImage);
		
		//Derinlik verilerinin dizini almak ve yerin mesafesini göstermek için
		int index = (depthPointY * depthWidth) + depthPointX;
		std::stringstream ss;
		ss << depthBuffer[index] << "mm";

		namedWindow("Kücültülmüs Depth Image", CV_WINDOW_AUTOSIZE);
		imshow("Kücültülmüs Depth Image", resizingImage);


		//cvtColor(resizingImage, img_gray, CV_RGB2GRAY);

		//CvSVM svm2;
		////Mat 
		//svm2.load("C:\\Users\\Asus\\Desktop\\Kinect_SVM\\SVMTraining\\SVMTraining\\SVMTrainingForc.xml");
		////cvtColor(resizingImage, img_gray, CV_RGB2GRAY);

		//CvSVM svm3;
		////Mat 
		//svm3.load("C:\\Users\\Asus\\Desktop\\Kinect_SVM\\SVMTraining\\SVMTraining\\SVMTrainingFort.xml");
		////cvtColor(resizingImage, img_gray, CV_RGB2GRAY);
		

		//HOG ozellik cıkarımı  
		HOGDescriptor d(Size(32, 16), Size(8, 8), Size(4, 4), Size(4, 4), 9);
		vector< float> descriptorsValues;
		vector< Point> locations;
		d.compute(resizingImage, descriptorsValues, Size(0, 0), Size(0, 0), locations);
		//vector to Mat  
		Mat fm = Mat(descriptorsValues);

	   //sınıflandırma yani verinin classına karar veren kod
		int result = svm.predict(fm);
		int result1 = svm1.predict(fm);
		int result2 = svm2.predict(fm);
		int result3 = svm3.predict(fm);
		/*int result1 = svm1.predict(fm);
		int result2 = svm2.predict(fm);
		*/


		int ddd = 0;
		//tahmin sonucuna göre de label yazıdırma
		if (result == 1){
			printf("%s - > %d\n", FullFileName, result);

			putText(depthImage, "1", Point(20, 30), CV_FONT_HERSHEY_COMPLEX, 2, Scalar(0, 0, 0));

		}
		else 	if (result1 == 4){
			printf("%s - > %d\n", FullFileName, result1);


			putText(depthImage, "4", Point(20, 30), CV_FONT_HERSHEY_COMPLEX, 2, Scalar(0, 0, 0));
		}

		else 	if (result2 == 5){
			printf("%s - > %d\n", FullFileName, result2);


			putText(depthImage, "C", Point(20, 30), CV_FONT_HERSHEY_COMPLEX, 2, Scalar(0, 0, 0));
		}
		else 	if (result3 == 6){
			printf("%s - > %d\n", FullFileName, result3);


			putText(depthImage, "T", Point(20, 30), CV_FONT_HERSHEY_COMPLEX, 2, Scalar(0, 0, 0));
		}


		namedWindow(DepthWindowName, CV_WINDOW_NORMAL);
		cv::imshow(DepthWindowName, depthImage);
	}
};

void main()
{
	try {

		//Egitim verisinin gercek zamanda projeye dahil edilmesi
		//Yani kinect acılırken bir kez egitilmis verilerinin yer aldıgı xml okunur
		//O verilere göre de tahmin yapılır
		svm.load("C:\\Users\\Asus\\Desktop\\Kinect_SVM\\SVMTraining\\SVMTraining\\SVMTrainingFor1.xml");
		svm1.load("C:\\Users\\Asus\\Desktop\\Kinect_SVM\\SVMTraining\\SVMTraining\\SVMTrainingFor4.xml");
		svm2.load("C:\\Users\\Asus\\Desktop\\Kinect_SVM\\SVMTraining\\SVMTraining\\SVMTrainingForc.xml");
		svm3.load("C:\\Users\\Asus\\Desktop\\Kinect_SVM\\SVMTraining\\SVMTraining\\SVMTrainingFort.xml");

		KinectApp app;
		app.initialize();
		app.run();

	}
	catch (std::exception& ex){
		std::cout << ex.what() << std::endl;
	}
}

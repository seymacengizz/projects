package genericStringTextAnalyzer;

//NESLÝHAN HANECÝOÐLU 1105011017
//SEYMA CENGÝZ 1105011031
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

public class ProjectPart1 {
	private FeatureExtracter extracter;
	public  void posOrNeg(String text) throws IOException {

		float positive = 1, negative = 1;
      //splitting the entering text from keyboard		
		String[] part = text.split(" ");

		FileReader file = new FileReader("frequency.txt");
		BufferedReader reader = new BufferedReader(file);
		String satir;

      //initialization		
		int j = 0;
		String[] txt_Part = null;
		
		String satir1 = reader.readLine();    //reading first row 

		String satir2 = reader.readLine();    //reading first row 
		String[] str2 = satir2.split(" ");    //splitting first row
		
		int numberOfPos= Integer.valueOf(str2[0]);   //12500
		int numberOfWordRew=Integer.valueOf(str2[1]);//2875321
		System.out.println("numOfWordRew :"+numberOfWordRew);
		int eachWordOccur;
		float POS;
		
		int numberOfNeg=12500;
		
		//P(POS)= 12500/25000
		POS = (float)numberOfPos/(numberOfNeg+numberOfPos);   //first split value is positive value
		System.out.println("POS :"+POS);
		positive*=POS;
//		negative += Math.log10(Float.valueOf(str1[1]));   //second split value is negative value
	
		while ((satir = reader.readLine()) != null) //This code will run, if the value or word is exist in file
		{
			txt_Part = satir.split(" ");            //splitting every text row
			if(satir!="###########################"){
			while (j <part.length) {               //continue with the length of the sentence entered from the keyboard
				if (txt_Part[0].equals(part[j])) { //if index-0 of all text in file equal to any word of the sentence entered from the keyboard
				
				eachWordOccur=Integer.valueOf((txt_Part[1]));
					System.out.println("eachWordOccur :"+eachWordOccur);	
				
					positive *= ((float)eachWordOccur/numberOfWordRew);//P(pos|x)=P(pos)*P(x|pos)

					j++;
				}
				break;   //break the splitting word and next the splitting other word
			}
			}
			else if(satir=="###########################")
			{
				j=0;
				while (j <part.length) {               //continue with the length of the sentence entered from the keyboard
					if (txt_Part[0].equals(part[j])) { //if index-0 of all text in file equal to any word of the sentence entered from the keyboard
					
					eachWordOccur=Integer.valueOf((txt_Part[1]));
						System.out.println("eachWordOccur :"+eachWordOccur);	
					
						negative *=((float)eachWordOccur/numberOfWordRew);  //P(neg|x)=P(neg)*P(x|neg)
						j++;
					}
					break;   //break the splitting word and next the splitting other word
				}
			}
		}
		System.out.println("positive :"+positive);
		if ((positive) > (negative))
			System.out.println( "<<<< Positive >>>>\n");
		else
			System.out.println( ">>>> Negative <<<<\n");

	}
//	File folder = new File("frequency.txt");
//	File[] listOfFiles = folder.listFiles();
//	HashMap<String, Integer> map= new HashMap<String, Integer>();
//	for (int i = 0; i < listOfFiles.length; i++) {
//		if (listOfFiles[i].isFile()) {
//
//			String content = readFile(listOfFiles[i]);
//			
//			List<String> features = extracter.extractFeatures(content);
//			
//			for(String feature : features)
//			{
//				Integer count = map.get(feature);
//				
//				if(count == null)
//				{
//					count = 0;
//				}
//				
//				count++;
//				
//				map.put(feature, count);
//				
//			}
//			}
//		}
//		}
//	private  String readFile(File file) throws IOException {
//		
//		BufferedReader reader = new BufferedReader(new FileReader(file));
//		
//		String line = null;
//		
//		StringBuilder stringBuilder = new StringBuilder();
//		
//		String ls = System.getProperty("line.separator");
//
//		while ((line = reader.readLine()) != null) {
//			stringBuilder.append(line);
//			stringBuilder.append(ls);
//		}
//		reader.close();
//
//		return stringBuilder.toString();
//	}
}

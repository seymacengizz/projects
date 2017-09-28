//Seyma Cengiz/1105011031
//Neslihan Hanecioglu/1105011017
#pragma comment (lib,"winmm.lib")
#include <windows.h>
#include <stdlib.h>
#include <GL/glut.h>
#include <math.h>
#include <stdio.h>
#include <iostream>
#include "MMSystem.h"
#include "imageloader.h"
#include <vector>
#include <cstdlib>

struct Point
{
    float x, y;
    unsigned char r, g, b, a;
};
std::vector< Point > points;

using namespace std;
static float Xvalue = 0.0, Yvalue = 0.0, Angle = 0.0,a=0.0;
//for terminates the program,the user can press ESC
void handleKeypress(unsigned char key, int x, int y) {
	switch (key) {
		case 27: //Escape key
			exit(0);
	}
}

int MoveX = 100;
int MoveY = 0;
int MoveZ = 100; 
int MoveX1 = 400;
int MoveX2 = 200;
int MoveX3 =1780;
int MoveX4 = 1200;
int MoveX5 = 1300;
void myInit(void) {
 glClearColor (0.0, 0.0, 0.0, 0.0);  
}
 
 GLuint loadTexture(Image* image) {
	GLuint textureId;
	glGenTextures(2, &textureId); //Make room for our texture
	glBindTexture(GL_TEXTURE_2D, textureId); //Tell OpenGL which texture to edit
	//Map the image to the texture
	glTexImage2D(GL_TEXTURE_2D,                //Always GL_TEXTURE_2D
				 0,                            //0 for now
				 GL_RGB,                       //Format OpenGL uses for image
				 image->width, image->height,  //Width and height
				 0,                            //The border of the image
				 GL_RGB, //GL_RGB, because pixels are stored in RGB format
				 GL_UNSIGNED_BYTE, //GL_UNSIGNED_BYTE, because pixels are stored
				                   //as unsigned numbers
				 image->pixels);               //The actual pixel data
	return textureId; //Returns the id of the texture
}

GLuint _textureIdSun; //The id of the textur
GLuint _textureIdEarth; //The id of the textur
GLuint _textureIdMars;
GLuint _textureIdMoon;
GLuint _textureIdMercur;
GLuint _textureIdJupiter;
GLuint _textureIdUranus;
GLuint _textureIdVenus;
GLuint _textureIdSaturn;
GLuint _textureIdNeptun;

GLUquadric *quad;
GLUquadric *quadEarth;
GLUquadric *quadMercur;
GLUquadric *quadMars;
GLUquadric *quadMoon;
GLUquadric *quadJupiter;
GLUquadric *quadVenus;
GLUquadric *quadUranus;
GLUquadric *quadSaturn;
GLUquadric *quadNeptun;
float rotate;

void initRendering() {
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
 
//	glEnable(GL_NORMALIZE);
	glEnable(GL_COLOR_MATERIAL);
	
	 quad = gluNewQuadric();
     Image* image = loadBMP("sun_images.bmp");
	_textureIdSun = loadTexture(image);
	 
  	 quadEarth = gluNewQuadric();
     Image* image1 = loadBMP("earth.bmp");
	_textureIdEarth = loadTexture(image1);
	
     quadMercur= gluNewQuadric();
     Image* image2 = loadBMP("mercury.bmp");
	_textureIdMercur = loadTexture(image2);
	
     quadMars= gluNewQuadric();
     Image* image3 = loadBMP("Mars.bmp");
	_textureIdMars = loadTexture(image3);
	
	 quadMoon= gluNewQuadric();
     Image* image4 = loadBMP("Moon.bmp");
	_textureIdMoon = loadTexture(image4);
	
	 quadJupiter= gluNewQuadric();
     Image* image5 = loadBMP("Jupiter.bmp");
	_textureIdJupiter = loadTexture(image5);
	
     quadVenus= gluNewQuadric();
     Image* image6 = loadBMP("venus.bmp");
	_textureIdVenus = loadTexture(image6);
	
	 quadUranus= gluNewQuadric();
     Image* image7 = loadBMP("uranus.bmp");
	_textureIdUranus = loadTexture(image7);
	
	 quadSaturn= gluNewQuadric();
     Image* image8 = loadBMP("Saturn.bmp");
	_textureIdSaturn = loadTexture(image8);
	
   	 quadNeptun= gluNewQuadric();
     Image* image9 = loadBMP("neptun.bmp");
	_textureIdNeptun = loadTexture(image9);
      delete image;
      delete image1;
      delete image2;
      delete image3;
      delete image4;
      delete image5;
      delete image6;
      delete image7;
      delete image8;
      delete image9;
}
static float xO[2880][2];
static float xO1[2880][2];
static float x1[360][2];
static float x2[360][2];
static float xMoon[360][2];
static float x3[720][2];
static float x4[1080][2];
static float x5[1440][2];
static float x6[1800][2];
static float x7[2160][2];
static float x8[2520][2];
static float x9[2880][2];
static float x0[2][2];

void generateCircle()
{
 int i = 0;

 //Mercur
  for(i=0; i <= 360; i++)
  {
   x1[i][0] = sin(i*3.1416/180)*2;
   x1[i][1] = cos(i*3.1416/180)*2;
  }
 //Sun
 for(i=0; i <= 360; i++)
 {
  x2[i][0] = sin(i*3.1416/180)*1;
  x2[i][1] = cos(i*3.1416/180)*1;
 }
 
 //Venus
 for(i=0; i <= 720; i++)
 {
  x3[i][0] = sin(i*3.1416/180)*3;
  x3[i][1] = cos(i*3.1416/180)*3;
 }
 
 //Earth
 for(i=0; i <= 1080; i++)
 {
  x4[i][0] = sin(i*3.1416/180)*4;
  x4[i][1] = cos(i*3.1416/180)*4;
 }
 //Moon
 for(i=0; i <= 360; i++)
 {
  xMoon[i][0] = sin(i*3.1416/180)*1;
  xMoon[i][1] = cos(i*3.1416/180)*1;
 }
 
 //Mars
 for(i=0; i <= 1440; i++)
 {
  x5[i][0] = sin(i*3.1416/180)*5;
  x5[i][1] = cos(i*3.1416/180)*5;
 }
 
 //Jupiter
 for(i=0; i <= 1800; i++)
 {
  x6[i][0] = sin(i*3.1416/180)*6;
  x6[i][1] = cos(i*3.1416/180)*6;
 }
 
 //Saturun
 for(i=0; i <= 2160; i++)
 {
  x7[i][0] = sin(i*3.1416/180)*7;
  x7[i][1] = cos(i*3.1416/180)*7;
 }
 
 //Uranus
 for(i=0; i <= 2520; i++)
 {
  x8[i][0] = sin(i*3.1416/180)*8;
  x8[i][1] = cos(i*3.1416/180)*8;
 }
 //Neptun
 for(i=0; i <= 2880; i++)
 {
  x9[i][0] = sin(i*3.1416/180)*9;
  x9[i][1] = cos(i*3.1416/180)*9;
 }
}

 void DrawOrbit(int a,int b)
{
   glBegin(GL_LINE_STRIP);
    for (int i = 0; i <a; i++)
    {                                    
      xO[i][0] = sin(i*3.1416/180)*b;
      xO1[i][1]= cos(i*3.1416/180)*b;
      glVertex3f(xO[i][0],xO1[i][1],0 );  
    }
    glEnd(); 
}
  
void myDisplay(void) {

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  
    gluLookAt (-15.0, -5.5, -20.0, -10.0, 5.0, 5.0, 5.0, 10.0, 1.0);
    glColor3ub( 255, 255, 255 );
    glEnableClientState( GL_VERTEX_ARRAY );
    glVertexPointer( 2, GL_FLOAT, sizeof(Point), &points[0].x );
    glPointSize( 2.0 );
    glDrawArrays( GL_POINTS, 0, points.size() );
    glDisableClientState( GL_VERTEX_ARRAY );

	glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();

//SUN
    glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, _textureIdSun);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glPushMatrix();
    gluLookAt (0.0, 11.0, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0);
    
    glRotatef(Angle, 0.0, 0.0,1.0);
    gluQuadricTexture(quad,1);
    gluSphere(quad,1,10,10);
    glPopMatrix();
 
//MERCUR
    glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, _textureIdMercur);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

    glPushMatrix();
    gluLookAt (0.0, 11.5, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0);
     DrawOrbit(360,2);
    if(MoveX==360)
       MoveX = 0;
       glTranslatef(x1[MoveX][1], x1[MoveX][0], 0.0);
       glRotatef(Angle, 0.0, 0.0, 1.0);
       gluQuadricTexture(quadMercur,1);
       gluSphere(quadMercur,0.2,10,10);
        glPopMatrix();
        
//VENUS
    glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, _textureIdVenus);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glPushMatrix();
    gluLookAt (0.0, 11.5, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0);
     DrawOrbit(720,3);
    if(MoveY==720)
       MoveY = 0;
       glTranslatef(x3[MoveY/2][1], x3[MoveY/2][0], 0.0);
       glRotatef(Angle, 0.0, 0.0, 1.0);
       gluQuadricTexture(quadVenus,1);
       gluSphere(quadVenus,0.4,10,10);
       glPopMatrix();
 
//EARTH
    glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, _textureIdEarth);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glPushMatrix();
    gluLookAt (0.0, 11.5, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0);
      DrawOrbit(1080,4);
    if(MoveZ==1080)
       MoveY = 0;
       glTranslatef(x4[MoveZ/3][1], x4[MoveZ/3][0], 0.0);
       glRotatef(Angle, 0.0, 0.0, 1.0);
       gluQuadricTexture(quadEarth,1);
       gluSphere(quadEarth,0.45,10,10);
        glEnable(GL_TEXTURE_2D);
  	    glBindTexture(GL_TEXTURE_2D, _textureIdMoon);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
        glTranslatef(xMoon[MoveZ/6][0], x2[MoveZ/6][1], 0.0);
        gluQuadricTexture(quadMoon,1);
        gluSphere(quadMoon,0.2,10,10);
        glPopMatrix();

//MARS
    glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, _textureIdMars);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glPushMatrix();
    gluLookAt (0.0, 11.5, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0);
    DrawOrbit(1440,5);
    if(MoveX1==1440)
       MoveX1 = 0;
       glTranslatef(x5[MoveX1/4][1], x5[MoveX1/4][0], 0.0);
       glRotatef(Angle, 0.0, 0.0, 1.0);
       gluQuadricTexture(quadMars,1);
       gluSphere(quadMars,0.3,10,10);
       glPopMatrix();
  
//JUPITER
    glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, _textureIdJupiter);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glPushMatrix();
    gluLookAt (0.0, 11.5, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0);
    DrawOrbit(1800,6);
    if(MoveX2==1800)
       MoveX2 = 0;
       glTranslatef(x6[MoveX2/5][1], x6[MoveX2/5][0], 0.0);
       glRotatef(Angle, 0.0, 0.0, 1.0);
       gluQuadricTexture(quadJupiter,1);
       gluSphere(quadJupiter,0.6,10,10);
       glPopMatrix();
 
//SATURN
    glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, _textureIdSaturn);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glPushMatrix();
    gluLookAt (0.0,11.5, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0);
    DrawOrbit(2160,7);
    if(MoveX3==2160)
       MoveX3 = 0;
       glTranslatef(x7[MoveX3/6][1], x7[MoveX3/6][0], 0.0);
       glRotatef(Angle, 0.0, 0.0, 1.0);
       gluQuadricTexture(quadSaturn,1);
       gluSphere(quadSaturn,0.5,10,10);
    int i = 0; 
    //Marsýn Uzerindeki Cizgiyi Ciziyo burda Marsýn cevresi kadar olusturmus
    glBegin(GL_QUAD_STRIP);
    for(i=0; i <= 1080; i++)
       {
        glVertex3f(sin(i*3.1416/180)*0.5, cos(i*3.1416/180)*0.5, 0 );
        glVertex3f(sin(i*3.1416/180)*0.7, cos(i*3.1416/180)*0.7, 0 );
       }
    glEnd();
    glRotatef(Angle, 0.0, 0.0, 1.0);
    glPopMatrix();

//URANUS
    glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, _textureIdUranus);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glPushMatrix();
    gluLookAt (0.0, 11.5, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0);
     DrawOrbit(2520,8);
    if(MoveX4==2520)
       MoveX4 = 0;
       glTranslatef(x8[MoveX4/7][1], x8[MoveX4/7][0], 0.0);
       glRotatef(Angle, 0.0, 0.0, 1.0);
       gluQuadricTexture(quadUranus,1);
       gluSphere(quadUranus,0.47,10,10);
       glPopMatrix();

//NEPTUN
    glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, _textureIdNeptun);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glPushMatrix();
    gluLookAt (0.0, 11.5, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0);
      DrawOrbit(2880,9);
    if(MoveX5==2880)
       MoveX5 = 0;
       glTranslatef(x9[MoveX5/8][1], x9[MoveX5/8][0], 0.0);
       glRotatef(Angle, 0.0, 0.0, 1.0);
       gluQuadricTexture(quadNeptun,1);
       gluSphere(quadNeptun,0.46,10,10);
       glPopMatrix();  
       glutSwapBuffers();
}

void resize(int w, int h)
{
 glViewport (0, 0, (GLsizei) w, (GLsizei) h); 
 glMatrixMode (GL_PROJECTION);
 glLoadIdentity ();
 gluPerspective(80.0,(GLdouble)w/(GLdouble)h,0.1000,500.0);
 glMatrixMode (GL_MODELVIEW);
 glLoadIdentity ();
}

void animation(int value)
{
	a+=0;
    Angle += 15.0;
    glutPostRedisplay();
    MoveX +=1;
    MoveY +=1;
    MoveZ +=1;
    MoveX1 +=1;
    MoveX2 +=1;
    MoveX3 +=1;
    MoveX4 +=1;
    MoveX5 +=1;
    glutPostRedisplay();
 //Arrange rotation time
glutTimerFunc(100, animation, 0);
}

int main(int argc, char ** argv){
    PlaySound(TEXT("solar.wav"),NULL,SND_ASYNC|SND_FILENAME|SND_LOOP);
    glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(5000, 5000);
    glutCreateWindow("OpenGL");
    initRendering();
    glutDisplayFunc(myDisplay);
    glutReshapeFunc(resize);  
    generateCircle();
 	glutKeyboardFunc(handleKeypress);
    glutTimerFunc(100, animation, 0);
    
 // populate points
    for( size_t i = 0; i < 1000; ++i )
    {
        Point pt;
        pt.x = -50 + (rand() % 150);
        pt.y = -50 + (rand() % 150);
      
        points.push_back(pt);
    }    
    glutMainLoop();
    return 0;
}

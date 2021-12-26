import hypermedia.video.*;
import java.awt.*;

OpenCV opencv;

Actions[] colorActions;
 
int calibrationKey = 0;

int windowHeight = 480;
int windowWidth = 640;

color rectangleColor;

PImage colorFilter;
PImage redFilter;
PImage greenFilter;
PImage blueFilter;

color redValue = color(0, 0, 0);
color greenValue = color(0, 0, 0);
color blueValue = color(0, 0, 0);

int redThreshold = 0;
int greenThreshold = 0;
int blueThreshold = 0;

int amountOfBlobs = 1;

int counter = 0;
int countermax = 15;

Personality p = new Personality();
int ptype = 0;

void setup() {
  size(windowWidth, windowHeight);
  frameRate(30);
  
  opencv = new OpenCV(this);
  opencv.capture(windowWidth, windowHeight);
  
  tts = new TTS();
  
  colorActions = new Actions[3];
  for (int i = 0; i < 3; i++) {
    colorActions[i] = new Actions();  
  }
}

void draw() {
  background(0);
  imageFilter();
  
  //Draw Image
  image(colorFilter, 0, 0);
  
  //Blob Detector
  for (int i = 0; i < 3; i++) {
    switch(i) {
      case 0:
        opencv.copy(redFilter);
        rectangleColor = color(255, 0, 0);
        break;
      case 1:
        opencv.copy(greenFilter);
        rectangleColor = color(0, 255, 0);
        break;
      case 2:
        opencv.copy(blueFilter);
        rectangleColor = color(0, 0, 255);
        break;
      default:
        break;
    }
    opencv.blur(OpenCV.BLUR, 20);
    
    //Blobs
    Blob[] blobs = opencv.blobs(60, ((width * height) / 2), amountOfBlobs, false, (OpenCV.MAX_VERTICES * 4));

    //Actions
    if(counter == 0) {
    
    colorActions[i].previousCount = colorActions[i].presentCount;
    colorActions[i].presentCount = blobs.length;
    if (colorActions[i].presentCount > colorActions[i].previousCount) {
      print(i);
      println(" Added");
      colorActions[i].added = true; 
      colorActions[i].removed = false;
      colorAdded(i);
    }
    else if (colorActions[i].presentCount < colorActions[i].previousCount) {
      print(i);
      println(" Removed");
      colorActions[i].added = false;
      colorActions[i].removed = true;
      colorRemoved(i);  
    }
    else {
      colorActions[i].added = false;
      colorActions[i].removed = false; 
      colorNothing(i);
    }
    
    for(int j = 0; j < blobs.length; j++) {
      colorActions[i].previousX = colorActions[i].presentX;
      colorActions[i].previousY = colorActions[i].presentY;
      colorActions[i].presentX = blobs[j].rectangle.x;
      colorActions[i].presentY = blobs[j].rectangle.y;
      float distance = sqrt((sq(colorActions[i].presentX - colorActions[i].previousX)) + sq((colorActions[i].presentY - colorActions[i].previousY)));
      if(distance > colorActions[i].threshold) {
        print(i);
        println(" Moved");  
        colorMoved(i);
      }
    }
    
    }
    counter++;
    if (counter == (countermax + 1)) {
      counter = 0;
    }
    
    //Bounding Box
    for(int j = 0; j < blobs.length; j++) {
      Rectangle boundingRectangle = blobs[j].rectangle;
      PImage boundingBox = createImage(boundingRectangle.width, boundingRectangle.height, RGB);
      
      for (int y = 0; y < boundingBox.height; y++) {
        for (int x = 0; x < boundingBox.width; x++) {
          boundingBox.set(x, y, rectangleColor);
        }
      }
      
      //Draw Bounding Box
      image(boundingBox, boundingRectangle.x, boundingRectangle.y);
    }
  }
}

void imageFilter() {
  opencv.read();
  opencv.flip(OpenCV.FLIP_HORIZONTAL);
  
  colorFilter = createImage(windowWidth, windowHeight, RGB);
  redFilter = createImage(windowWidth, windowHeight, RGB);
  greenFilter = createImage(windowWidth, windowHeight, RGB);
  blueFilter = createImage(windowWidth, windowHeight, RGB);
  
  colorFilter = opencv.image();
  redFilter = opencv.image();
  greenFilter = opencv.image();
  blueFilter = opencv.image();
  
  //opencv.convert(OpenCV.GRAY);
  //opencv.invert();
  //PImage grayFilter = createImage(windowWidth, windowHeight, RGB);
  //grayFilter = opencv.image();
  
  for (int y = 0; y < windowHeight; y++) {
    for (int x = 0; x < windowWidth; x++) {
      color colorPixel = colorFilter.get(x, y);
      int redPixel = (colorPixel >> 16) & 0xFF;
      int greenPixel = (colorPixel >> 8) & 0xFF;
      int bluePixel = (colorPixel) & 0xFF;

      colorFilter.set(x, y, color(redPixel, greenPixel, bluePixel));

      //redFilter
      if (redPixel >= greenPixel && redPixel >= bluePixel) {
        if (redPixel < (red(redValue) + redThreshold) && redPixel > (red(redValue) - redThreshold) &&
            greenPixel < (green(redValue) + redThreshold) && greenPixel > (green(redValue) - redThreshold) &&
            bluePixel < (blue(redValue) + redThreshold) && bluePixel > (blue(redValue) - redThreshold)) {
          redFilter.set(x, y, color(255, 255, 255));  
        }
        else {
          redFilter.set(x, y, color(0, 0, 0)); 
        }
      }
      else {
        redFilter.set(x, y, color(0, 0, 0));  
      } 
      
      //greenFilter
      if (greenPixel >= redPixel && greenPixel >= bluePixel) {
        if (redPixel < (red(greenValue) + greenThreshold) && redPixel > (red(greenValue) - greenThreshold) &&
            greenPixel < (green(greenValue) + greenThreshold) && greenPixel > (green(greenValue) - greenThreshold) &&
            bluePixel < (blue(greenValue) + greenThreshold) && bluePixel > (blue(greenValue) - greenThreshold)) {
          greenFilter.set(x, y, color(255, 255, 255));  
        }
        else {
          greenFilter.set(x, y, color(0, 0, 0)); 
        }
      }
      else {
        greenFilter.set(x, y, color(0, 0, 0));  
      } 
      
      //blueFilter
      if (bluePixel >= redPixel && bluePixel >= greenPixel) {
        if (redPixel < (red(blueValue) + blueThreshold) && redPixel > (red(blueValue) - blueThreshold) &&
            greenPixel < (green(blueValue) + blueThreshold) && greenPixel > (green(blueValue) - blueThreshold) &&
            bluePixel < (blue(blueValue) + blueThreshold) && bluePixel > (blue(blueValue) - blueThreshold)) {
          blueFilter.set(x, y, color(255, 255, 255));  
        }
        else {
          blueFilter.set(x, y, color(0, 0, 0)); 
        }
      }
      else {
        blueFilter.set(x, y, color(0, 0, 0));  
      }  
    }
  } 
}

int multiplyFilter(int topColor, int bottomColor) {
  int multiplyColor = ((topColor * bottomColor) / 255);
  return multiplyColor;  
}

int screenFilter(int topColor, int bottomColor) {
  int screenColor = 255 - (((255 - topColor) * (255 - bottomColor)) / 255);  
  return screenColor;
}

int overlayFilter(int topColor, int bottomColor) {
  int overlayColor = multiplyFilter(screenFilter(topColor, topColor), screenFilter(bottomColor, bottomColor));
  return overlayColor;
}



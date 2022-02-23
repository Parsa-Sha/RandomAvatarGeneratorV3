import java.io.File;

boolean systemInProgress = false;
File dir = new File(sketchPath());
File [] files = dir.listFiles();
int numberOfFiles = files.length;

PImage allImages[] = new PImage[500];
int alphabetCount[] = new int[26];
boolean alphabetCountExists[] = new boolean[26];
boolean frameSaved = false;
int headCount = 0;
String currentFile;
char currentFileChar;
char pastFileChar;
int numberOfCurrentLetterFiles = 0;
int indexOfCurrentLetterArray = 0;
int numberOfLetters = 0;
String fileNames[][] = new String [26][100];

void setup() {
  size(600, 850);
  background(128);
  textSize(25);
  stroke(255);
  textAlign(CENTER);
  text("Press 'R' to generate random image, 'S' to save", width/2, height/2);
  
  dir = new File(sketchPath() + "\\input");
  File files[] = dir.listFiles();
  numberOfFiles = files.length;
  
  numberOfCurrentLetterFiles = 0;
  pastFileChar = 'a';
  
  for(int i = 0; i < alphabetCountExists.length; i++) alphabetCountExists[i] = false;
  for (int i = 0; i < numberOfFiles; i++){  
    currentFile = files[i].getName();
    currentFileChar = currentFile.charAt(0);
    if (pastFileChar != currentFileChar || i == numberOfFiles-1) {
      if(i == numberOfFiles-1) alphabetCount[indexOfCurrentLetterArray] = numberOfCurrentLetterFiles + 1;
      else alphabetCount[indexOfCurrentLetterArray] = numberOfCurrentLetterFiles;
      alphabetCountExists[indexOfCurrentLetterArray] = true;
      indexOfCurrentLetterArray++;
      numberOfCurrentLetterFiles = 1;
    } else {
      numberOfCurrentLetterFiles++; 
    }
    pastFileChar = currentFileChar;
    fileNames[indexOfCurrentLetterArray][numberOfCurrentLetterFiles-1] = files[i].getName();
  }
  
  
  for(int i = 0; i < 26; i++) {
    if(alphabetCountExists[i]) numberOfLetters++;
  }
  fileNames[numberOfLetters-1][alphabetCount[numberOfLetters-1]-1] = files[numberOfFiles-1].getName();
  
  println(fileNames[2][6]);
}

void draw() {}

void keyPressed() {
  if(key=='r'||key=='R'){
    background(128);
    for(int i = 0; i < alphabetCount.length; i++) {    
      if (alphabetCountExists[i] == true){
        int randomSelector = floor(random(alphabetCount[i]));
        int currentCharCode = 97+i;
        char alphabetChar = char(currentCharCode);
        PImage aImage = loadImage("input\\" + alphabetChar + nf((randomSelector + 1), 3) + ".png");
        image(aImage, 0, 0);
      }
    }
  }
  
  if(key=='a'||key=='A'){
    for(int i = 0; i < alphabetCount.length; i++) {    
      if (alphabetCountExists[i] == true){
        for(int j = 0; j < alphabetCount[i]; j++) {
          for(int k = 0; k < alphabetCount.length; k++) {    
            if (alphabetCountExists[k] == true){
              int randomSelector = j;
              int currentCharCode = 97+k;
              char alphabetChar = char(currentCharCode);
              PImage aImage = loadImage("input\\" + alphabetChar + nf((randomSelector + 1), 3) + ".png");
              image(aImage, 0, 0);
            }    
          }
        saveFrame("output\\composite" + nf(headCount, 6) + ".png");
        }
      }
    }
  }
  
  if(key=='s'||key=='S') {
    saveFrame("output\\composite" + nf(headCount, 6) + ".png");
    headCount++;
    rectMode(CENTER);
    fill(0);
    rect(width/2, height/2, 250, 100);
    fill(255);
    text("Image Saved.", width/2, height/2 + 10);
  }
}

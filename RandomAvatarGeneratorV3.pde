// Includes All Combinations

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
int possibleCombinations = 1;


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
    fileNames[indexOfCurrentLetterArray][numberOfCurrentLetterFiles-1] = files[i].getName(); // Loading file names into a 2d array
  }
  
  
  for(int i = 0; i < 26; i++) { // Very last file has issues, so entering it manually 
    if(alphabetCountExists[i]) numberOfLetters++;
  }
  fileNames[numberOfLetters-1][alphabetCount[numberOfLetters-1]-1] = files[numberOfFiles-1].getName();
  
  
  for(int i = 0; i < numberOfLetters; i++) possibleCombinations *= alphabetCount[i];

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
    // Making the array
    int currentSelection[] = new int[26];
    int allCombinations[][] = new int[possibleCombinations][numberOfLetters];
    for(int j = 0; j < possibleCombinations; j++){ // Finishes when All Combinations have been discovered
      background(128);  
      while(true){ // Will break when combination is found, and cleared the checking process
        for(int i = 0; i < numberOfLetters; i++){ // Writing Current Random
          currentSelection[i] = floor(random(alphabetCount[i]));
        }
        if(ifArraysAreEqualOfAll(currentSelection, allCombinations, numberOfLetters)) { // Cleared j combinations
          break;
        }
      }
      
      for(int i = 0; i < numberOfLetters; i++){
        int currentInt = i+97;
        char currentChar = char(currentInt);
        PImage aImage = loadImage("input\\"+currentChar+nf(currentSelection[i]+1, 3) + ".png");
        image(aImage, 0, 0);
        allCombinations[j] = currentSelection;
      }
      saveFrame("output\\composite" + nf(headCount, 6) + ".png");
      headCount++;
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

boolean ifArraysAreEqual(int array1[], int array2[]){
  int cleared = 0;
  for(int i = 0; i < array2.length; i++) if(array1[i]==array2[i]) cleared++;
  if(cleared == array2.length) return true;
  return false;
}

boolean ifArraysAreEqualOfAll(int array1[], int array2[][], int filledRows){
  int arraysCleared = 0;
  for(int i = 0; i < filledRows; i++) if(ifArraysAreEqual(array1, array2[i])) arraysCleared++;
  if(arraysCleared == filledRows) return true;
  return false;
}

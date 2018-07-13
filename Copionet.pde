
import drop.*; 
import ngrams.*;
import java.util.*;

static final int INITIAL_APPSTATE = 0;
static final int SCAN_APPSTATE = 1;
static final int RESULTS_APPSTATE = 2;
static final int DETAILS_APPSTATE = 3;
static final int EXPORT_APPSTATE = 4;

SDrop drop; //drop handler
File dropObject; //object droped
File[] filenames; //array of files droped
int app_state = INITIAL_APPSTATE;
int selectedDoc = -1;

PFont myFont;
PImage logoImage;
PImage dropFolderImage;

ArrayList<Document> documents = new ArrayList<Document>(); //array of processed document classes
HashSet<Integer>  ngramSet = new HashSet<Integer> (); //all the unique ngrams hashcoded
HashSet<Integer>  collisionSet = new HashSet<Integer> (); //all the collision ngrams hashcoded

void setup() { 
  //size(800,600);
  size(1024, 768);
  
  myFont = createFont("assets/AvenirNextLTPro-Demi.otf", 18);
  textFont(myFont);
  
  logoImage = loadImage("assets/copionet.png");
  dropFolderImage = loadImage("assets/folder-icon.png");
  
  drop = new SDrop(this); //drop files library object
 
} 


void draw() { 
  background(220); 
  
  switch(app_state) {
 
      case INITIAL_APPSTATE:
        displayHomePage();
      break;
 
      case SCAN_APPSTATE:
        displayScan();
      break;
 
      case RESULTS_APPSTATE:
        displayResults();
      break;

      case DETAILS_APPSTATE:
        displayDetails();
      break;
      
      case EXPORT_APPSTATE:
        displayExport();
      break;
      
      default:
      
      break;
 
  }//switch

} 

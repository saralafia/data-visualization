/***********************************
 * Sara Lafia 2D Assignment *
 * Created with Processing 3.2.3 *
 ***********************************/

// Declare variables
PFont font;
// margins for canvas
float verMargin = 100;
float horMargin = 150;
Table table;
int numCols, numRows;
float [][] dataMatrix;
float maxValue, minValue;
// width and height for each cell
float cellWidth, cellHeight;
// text labels
// interaction
boolean normalization = false;
boolean colorApply = false;
boolean click = false; 
// ArrayList<List> list = new ArrayList<List>();
float [][] list_points;

//year
String [] Year = {"2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016"};
int numYear = 11;

//language
String [] Language = {"Java", "Python", "PHP", "JavaScript", "Perl", "Ruby"};
int numLanguage = 6;

void setup() {
  // size(1280, 720); // setup the size of the window
  fullScreen();
  //font
  font = createFont("Roboto-Black.ttf", 38);
  textFont(font);

  // Seattle Public Library Table
  table = loadTable("2a_Lafia.csv", "header");
  // get the number of rows and cols
  numRows = table.getRowCount();
  numCols = table.getColumnCount();
  dataMatrix = new float[numCols-2][numRows];
  // println("Rows: " + numRows + " Columns: " + numCols);

  // get max and min value 
  for (int i=0; i<numCols-2; i++) {
    for (int j=0; j<numRows; j++) {
      dataMatrix[i][j] = table.getFloat(j, i+2);
    }
  }

  maxValue = max2D(dataMatrix);
  minValue = min2D(dataMatrix);
  // println("Max Value " + maxValue);
  // println("Min Value " + minValue);

  for (int i = 0; i<numRows; i++) 
  {
    int month = table.getInt(i, 0);
    int year = table.getInt(i, 1);
    int java = table.getInt(i, 2);
    int python = table.getInt(i, 3);
    int php = table.getInt(i, 4);
    int javascript = table.getInt(i, 5);
    int perl = table.getInt(i, 6);
    int ruby = table.getInt(i, 7);
    // list.add(new List(month, year, java, python, php, javascript, perl, ruby));
  }

  // println(list.get(0).python); //gets the python count from the first
  // println(list.get(23).month); //gets the month from the 24th 
}

void draw() {
  background(30);
  surface.setResizable(true);
  cellWidth = (width - 1.5*horMargin)/numRows;
  cellHeight = (height - 2*verMargin)/(numCols-2);
  // list_points = new float[list.size()][2];
  ArrayList<String> list = new ArrayList<String>();

  // Draw 2D Matrix
  for (int i=0; i<numCols-2; i++) {
    for (int j=0; j<numRows; j++) {
      stroke(50);
      strokeWeight(0.2);
      colorMode(HSB, 255, 255, 255);
      float freq = map(dataMatrix[i][j], minValue, maxValue, 65, 255);
      // point(0,0,0);
      // float mouseObjectDistance = sq(mouseX-screenX(0, 0, 0))+sq(mouseY-screenY(0, 0, 0));
      if (i == 0){
        fill(#d53e4f, freq);
      } else if (i == 1) {
        fill(#fc8d59, freq);
      } else if (i == 2) {
        fill(#fee08b, freq);
      } else if (i == 3) {
        fill(#e6f598, freq);
      } else if (i == 4) {
        fill(#99d594, freq);
      } else if (i == 5) {
        fill(#3288bd, freq);
      } else {
        fill(0, 0, 0);
      }
      // pushMatrix();
      // rect(x, y, width, height, radius)
      rect(horMargin+cellWidth*j, verMargin+cellHeight*i+30, cellWidth, cellHeight-10, 1);
      // popMatrix();
    }
  }

  // Draw vertical labels
  for (int q = 0; q < numLanguage; q++) {
    textAlign(RIGHT, CENTER);
    fill(255);
    textSize(14);
    text(Language[q], horMargin-20, verMargin + cellHeight/2 + cellHeight*q);
    // q*15+horMargin+5, verMargin+400);
  }

  // Draw year text
  for (int p = 0; p < numYear; p++) {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(Year[p], p*115+horMargin, verMargin);
  }

  // Draw title
  textSize(28);
  textAlign(CENTER, CENTER);
  text("TOWER OF BABEL: Programming Language Popularity by Proxy", width/2, verMargin/2-20);

  // Draw description
  textSize(14);
  textAlign(CENTER, BOTTOM);
  text("a decade of computer science reference books checked out each month by programming language at the Seattle Public Library", width/2, verMargin-25);

  // Draw user instructions
  textSize(14);
  textAlign(CENTER, BOTTOM);
  text("press the 'c' key to compare Google Keyword Frequency / press the 'x' key to view as x-ray / press 'esc' to exit", width/2, height-25);

  // Draw credits
  textSize(14);
  textAlign(CENTER, BOTTOM);
  text("M259 | Sara Lafia", width-130, height-25);

  // test interaction
  if (normalization == true) normalize();
  else if (normalization == false) reset();
  if (colorApply == true) colorscheme();
  else if (colorApply == false) reset();
  if (click) mousePressed();

  // export screenshot image
  //saveFrame("export.png");
}
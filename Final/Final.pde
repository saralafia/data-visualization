/*************************************************************************************
 M259 | Sara Lafia
 Final Data Visualization
 Adapted from 3D Tree Map Demo (by Rodger Jieliang Luo)                        
 Data: From Alexandria Digital Research Library, obtained on 2/11/2017. 
 Description: Counts of graduate student publications by topic modeled on subjects.
 Range: 2011-2016
 
 Usage: 
 1. Select Presentation Mode to cycle through all subjects automatically.
 2. Enter a specific subject number to see individual trajectory of pubs by subject.
 3. Press SPACE to cycle through all subjects manually. 
 4. Navigate Peasy Cam to explore the environment. 
 
 *************************************************************************************/

import treemap.*; //Tree Map library
import peasy.*; //3D Navigation library
import controlP5.*; //GUI library

//------------------------------------------------------------Constants Section
final int NUM_LAYERS = 6; // Number of layers, 6 years of data. 

final int LAYER_DIST = 400; // Distance between each treemap layer

final int TRANS = 90; // Transparency of treemap layers
//------------------------------------------------------------Variables Section
int selectedDept = -10; // No dept selected at the start
int selectedSubject = -10; // No subject selected at the start

boolean presentationMode = false; // when true, spins automatically 

PeasyCam cam;
ControlP5 cp5;
Textarea myTextarea;

//Data-Related Variables
Table topicTable;
Table topicListTable;
Table subjectTable;
int numTopicRows, numTopicColumns;
int numDeptRows, numDeptColumns;
float[][] dataMatrix;
String[] topics;
ArrayList<String> topicNames;
String[] subjects;
ArrayList<String> subjectNames;

//TreeMap-Related Variables
DeptMap[] deptData;
Treemap[] map;

//Variables for drawing rects
ArrayList<ArrayList<PVector>> pointsOne = new ArrayList<ArrayList<PVector>>(NUM_LAYERS);
ArrayList<ArrayList<PVector>> pointsTwo = new ArrayList<ArrayList<PVector>>(NUM_LAYERS);
ArrayList<ArrayList<PVector>> pointsThree = new ArrayList<ArrayList<PVector>>(NUM_LAYERS);
ArrayList<ArrayList<PVector>> pointsFour = new ArrayList<ArrayList<PVector>>(NUM_LAYERS);

//------------------------------------------------------------Setup Section
void setup() {
  size(1380, 820, OPENGL);

  //Initial camera and user interface 
  cam = new PeasyCam(this, 2000);
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  cam.setMinimumDistance(1500);        
  cam.setMaximumDistance(3500); 


  //Add controls at the top of canvas with Control P5 
  Textfield Dept = cp5.addTextfield("dept")
    .setPosition(160, 10)
    .setSize(50, 15)
    .setFocus(true)
    .setColor(color(0))
    .setColorBackground(color(255))
    .setColorActive(color(255))
    .setColorForeground(color(255))
    .setCaptionLabel("Topic Number (0 - 70)")
    ;
  Dept.getCaptionLabel().getStyle().marginTop  = -16; 
  Dept.getCaptionLabel().getStyle().marginLeft  = 55;

  cp5.addCheckBox("checkBox")
    .setPosition(20, 10)
    .setSize(15, 15) 
    .addItem("Presentation Mode", 1)
    ;  

  myTextarea = cp5.addTextarea("txt")
                  .setPosition(20,50)
                  .setSize(200,190)
                  .setLineHeight(14)
                  //.setColor(color(200))
                  .setColorBackground(color(255,100))
                  .setColorForeground(color(255,100));
                  ;
  myTextarea.setText("\n" + " UCSB Graduate Research Trends"
                    + "\n" + "\n" + "1,730 theses and dissertations are grouped into 70 topics derived from" +
                    " each document's free-text subject description." + "Topic popularity trajectories are mapped across annual treemaps, from 2011 - 2016."
                    + "\n" + "\n"+"Document metadata are derived from Alexandria Digital Research Library "
                    + "[http://alexandria.ucsb.edu/collections]"
                    );

  //Put data into Processing table from csv
  topicTable = loadTable("topic.csv", "header");
  numTopicRows = topicTable.getRowCount(); 
  numTopicColumns = topicTable.getColumnCount();
  dataMatrix = new float[numTopicColumns-1][numTopicRows];
  topics = new String[numTopicRows];
  println("Rows: " + numTopicRows + " Columns: " + numTopicColumns);
  topicListTable = loadTable("topicList.csv", "header");
  topicNames = new ArrayList<String>();
  for (int i=0; i<topicListTable.getRowCount(); i++) {
    topicNames.add(topicListTable.getString(i, 1));
  }

  //Put data from the table into a 2D array
  for (int i=0; i<numTopicColumns-1; i++) {
    for (int j=0; j<numTopicRows; j++) {
      dataMatrix[i][j] = topicTable.getFloat(j, i+1);
    }
  }

  //Save topic strings into a 1D array
  for (int i=0; i<numTopicRows; i++) {
    topics[i] = topicTable.getString(i, 0);
  }

  //Initialize tree map variables
  deptData = new DeptMap[NUM_LAYERS];
  map = new Treemap[NUM_LAYERS];
  for (int i=0; i<NUM_LAYERS; i++) { 
    deptData[i]= new DeptMap();
    pointsOne.add(new ArrayList<PVector>());
    pointsTwo.add(new ArrayList<PVector>());
    pointsThree.add(new ArrayList<PVector>());
    pointsFour.add(new ArrayList<PVector>());
  }

  //Add subject categories and counts into tree map data structure
  //Based on Ben Fry's Tree Map library. 
  //Details are in the reference of TreeMap library (http://benfry.com/writing/treemap/reference/)  
  for (int i=0; i<dataMatrix.length; i++) {
    for (int j=0; j<dataMatrix[i].length; j++) {
      deptData[i].addDepts(topics[j], (int)dataMatrix[i][j]);
    }
    deptData[i].finishAdd();
    map[i] = new Treemap(deptData[i], 0, 0, width, height);
  }

  //Caculate points coordinates of the whole tree map structure 
  for (int i=0; i<dataMatrix.length; i++) {

    //Caculate and save coordinates of central point of each rect
    for (int j=0; j<deptData[i].getItems().length; j++) {
      double x = deptData[i].getItems()[j].getBounds().x;
      double y = deptData[i].getItems()[j].getBounds().y;
      double w = deptData[i].getItems()[j].getBounds().w; 
      double h = deptData[i].getItems()[j].getBounds().h; 

      //Based on the central points, caculate coordinates of four corners of the rects 
      PVector pointOne = new PVector((int)x, (int)y, LAYER_DIST*(i-dataMatrix.length/2));
      pointsOne.get(i).add(pointOne);

      PVector pointTwo = new PVector((int)(x+w), (int)y, LAYER_DIST*(i-dataMatrix.length/2));
      pointsTwo.get(i).add(pointTwo);

      PVector pointThree = new PVector((int)(x+w), (int)(y+h), LAYER_DIST*(i-dataMatrix.length/2));
      pointsThree.get(i).add(pointThree);

      PVector pointFour = new PVector((int)x, (int)(y+h), LAYER_DIST*(i-dataMatrix.length/2));
      pointsFour.get(i).add(pointFour);
    }
  }
}

//------------------------------------------------------------Draw Section
void draw() {
  gui();
  background(50);
  colorMode(HSB); // Change the color mode to HSB
  if (cp5.getWindow().isMouseOver()) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }

  //Set automation in presentation mode 
  if (presentationMode) {
    rotateY(frameCount*0.001);
    if (frameCount % 120 == 0) {
      selectedDept += 1;
      if (selectedDept == 70) selectedDept = -1;
    }
  }

  //The volumetric shapes go through all layers are composed by four side meshes.   
  //The following codes draw four sides of meshes separately.

  //Draw Top Meshes
  pushMatrix();
  translate(-width/2, -height/2);
  for (int j=0; j<numTopicRows; j++) {
    for (int i=0; i<pointsOne.size()-1; i++) {
      float x1_1 = pointsOne.get(i).get(j).x;
      float y1_1 = pointsOne.get(i).get(j).y + 0.1;
      float z1_1 = pointsOne.get(i).get(j).z;

      float x2_1 = pointsTwo.get(i).get(j).x;
      float y2_1 = pointsTwo.get(i).get(j).y + 0.1;
      float z2_1 = pointsTwo.get(i).get(j).z;

      float x1_2 = pointsOne.get(i+1).get(j).x;
      float y1_2 = pointsOne.get(i+1).get(j).y + 0.1;
      float z1_2 = pointsOne.get(i+1).get(j).z;

      float x2_2 = pointsTwo.get(i+1).get(j).x;
      float y2_2 = pointsTwo.get(i+1).get(j).y + 0.1;
      float z2_2 = pointsTwo.get(i+1).get(j).z;

      float lineColor = Float.parseFloat(deptData[i].departments.keySet().toArray()[j].toString());

      beginShape();  
      noStroke();

      //The next a few lines of code controls color of shapes going through layers
      //Colors for the tree map layers are in SubjectItem class
      if (lineColor == selectedDept) {
        fill(map(lineColor, 0, 70, 0, 255), 255/2, 255, TRANS);
      } else {
        if (selectedDept >= 0) noFill();
        else fill(map(lineColor, 0, 70, 0, 255), 255/2, 255/2, TRANS);
      } 
      vertex(x1_1, y1_1, z1_1);
      vertex(x2_1, y2_1, z2_1);
      vertex(x2_2, y2_2, z2_2);
      vertex(x1_2, y1_2, z1_2);
      endShape();
    }
  }
  popMatrix();

  //Draw Bottom Meshes 
  pushMatrix();
  translate(-width/2, -height/2);
  for (int j=0; j<numTopicRows; j++) {
    for (int i=0; i<pointsThree.size()-1; i++) {
      float x1_1 = pointsThree.get(i).get(j).x;
      float y1_1 = pointsThree.get(i).get(j).y - 0.1;
      float z1_1 = pointsThree.get(i).get(j).z;

      float x2_1 = pointsFour.get(i).get(j).x;
      float y2_1 = pointsFour.get(i).get(j).y - 0.1;
      float z2_1 = pointsFour.get(i).get(j).z;

      float x1_2 = pointsThree.get(i+1).get(j).x;
      float y1_2 = pointsThree.get(i+1).get(j).y - 0.1;
      float z1_2 = pointsThree.get(i+1).get(j).z;

      float x2_2 = pointsFour.get(i+1).get(j).x;
      float y2_2 = pointsFour.get(i+1).get(j).y - 0.1;
      float z2_2 = pointsFour.get(i+1).get(j).z;

      float lineColor = Float.parseFloat(deptData[i].departments.keySet().toArray()[j].toString());     

      beginShape();
      noStroke();

      //The next a few lines of code controls color of shapes going through layers
      //Colors for the tree map layers are in SubjectItem class
      if (lineColor == selectedDept) {
        fill(map(lineColor, 0, 70, 0, 255), 255/2, 255, TRANS);
      } else {
        if (selectedDept >= 0) noFill();
        else fill(map(lineColor, 0, 70, 0, 255), 255/2, 255/2, TRANS);
      } 
      vertex(x1_1, y1_1, z1_1);
      vertex(x2_1, y2_1, z2_1);
      vertex(x2_2, y2_2, z2_2);
      vertex(x1_2, y1_2, z1_2);
      endShape();
    }
  }
  popMatrix();

  //Draw Left Meshes
  pushMatrix();
  translate(-width/2, -height/2);
  for (int j=0; j<numTopicRows; j++) {
    for (int i=0; i<pointsOne.size()-1; i++) {
      float x1_1 = pointsOne.get(i).get(j).x + 0.1;
      float y1_1 = pointsOne.get(i).get(j).y;
      float z1_1 = pointsOne.get(i).get(j).z;

      float x2_1 = pointsFour.get(i).get(j).x + 0.1;
      float y2_1 = pointsFour.get(i).get(j).y;
      float z2_1 = pointsFour.get(i).get(j).z;

      float x1_2 = pointsOne.get(i+1).get(j).x + 0.1;
      float y1_2 = pointsOne.get(i+1).get(j).y;
      float z1_2 = pointsOne.get(i+1).get(j).z;

      float x2_2 = pointsFour.get(i+1).get(j).x + 0.1;
      float y2_2 = pointsFour.get(i+1).get(j).y;
      float z2_2 = pointsFour.get(i+1).get(j).z;

      float lineColor = Float.parseFloat(deptData[i].departments.keySet().toArray()[j].toString());     

      beginShape();
      noStroke();

      //The next a few lines of code controls color of shapes going through layers
      //Colors for the tree map layers are in SubjectItem class
      if (lineColor == selectedDept) {
        fill(map(lineColor, 0, 70, 0, 255), 255/2, 255, TRANS);
      } else {
        if (selectedDept >= 0) noFill();
        else fill(map(lineColor, 0, 70, 0, 255), 255/2, 255/2, TRANS);
      } 
      vertex(x1_1, y1_1, z1_1);
      vertex(x2_1, y2_1, z2_1);
      vertex(x2_2, y2_2, z2_2);
      vertex(x1_2, y1_2, z1_2);
      endShape();
    }
  }
  popMatrix();

  //Draw Right Meshes
  pushMatrix();
  translate(-width/2, -height/2);
  for (int j=0; j<numTopicRows; j++) {
    for (int i=0; i<pointsTwo.size()-1; i++) {
      float x1_1 = pointsTwo.get(i).get(j).x - 0.1;
      float y1_1 = pointsTwo.get(i).get(j).y;
      float z1_1 = pointsTwo.get(i).get(j).z;

      float x2_1 = pointsThree.get(i).get(j).x - 0.1;
      float y2_1 = pointsThree.get(i).get(j).y;
      float z2_1 = pointsThree.get(i).get(j).z;

      float x1_2 = pointsTwo.get(i+1).get(j).x - 0.1;
      float y1_2 = pointsTwo.get(i+1).get(j).y;
      float z1_2 = pointsTwo.get(i+1).get(j).z;

      float x2_2 = pointsThree.get(i+1).get(j).x - 0.1;
      float y2_2 = pointsThree.get(i+1).get(j).y;
      float z2_2 = pointsThree.get(i+1).get(j).z;

      float lineColor = Float.parseFloat(deptData[i].departments.keySet().toArray()[j].toString());     
      lineColor = map(lineColor, 0, 990, 0, 255);

      beginShape();
      noStroke();

      //The next a few lines of code controls color of shapes going through layers
      //Colors for the tree map layers are in SubjectItem class
      if (lineColor == selectedDept) {
        fill(map(lineColor, 0, 70, 0, 255), 255/2, 255, TRANS);
      } else {
        if (selectedDept >= 0) noFill();
        else fill(map(lineColor, 0, 70, 0, 255), 255/2, 255/2, TRANS);
      } 
      vertex(x1_1, y1_1, z1_1);
      vertex(x2_1, y2_1, z2_1);
      vertex(x2_2, y2_2, z2_2);
      vertex(x1_2, y1_2, z1_2);
      endShape();
    }
  }
  popMatrix();

  //Draw the 6 tree map layers  
  for (int i=0; i<dataMatrix.length; i++) {
    pushMatrix();
    translate(-width/2, -height/2, LAYER_DIST*(i - dataMatrix.length/2));
    map[i].draw();
    popMatrix();
  }

  //Draw Title
  cam.beginHUD();  //Stopping peasy cam
  fill(150);
  rect(0, 0, width, 35);
  fill(255);
  textAlign(RIGHT);
  if (selectedDept >= 0 && selectedDept <= 71) {
    String deptName = topicNames.get(selectedDept);
    deptName = deptName.toUpperCase();
    text(selectedDept + " " + deptName, width-10, 20);
  }
  cp5.draw();
  cam.endHUD();

  // to export screenshot image, uncomment
  //saveFrame("export1.png");
}

//Function for showing each subject manually by pressing SPACE bar
void keyPressed() {
  if (key == ' ') {
    if (selectedDept < 0) selectedDept = 0;
    else selectedDept += 1;
    if (selectedDept == 47) selectedDept = -1;
  }
}

public void dept(String theText) {
  // automatically receives results from controller input
  // println("a textfield event for controller 'input' : "+theText);
  selectedDept = int(theText);
}

void checkBox(float[] a) {
  if (a[0] == 1) presentationMode = true;
  else presentationMode = false;
  }
  
void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}
/***********************************
 * Sara Lafia 3D Assignment *
 * Created with Processing 3.2.3 *
 * CHANGES *
 * updated dataset and applied LDA *
 * TODO *
 * enable filtering by topic *
 * show book titles in flat field *
 ***********************************/

import peasy.*;
PeasyCam cam;

import controlP5.*;
ControlP5 cp5;

import processing.opengl.*;

//checkbox
CheckBox checkbox;
CheckBox checkbox1;
Textlabel textLabel;

boolean data1 = false;

boolean text1 = false;
boolean text2 = false;
boolean text3 = false;
boolean text4 = false;

//boolean topic1 = false;
//boolean topic2 = false;
//boolean topic3 = false;
//boolean topic4 = false;
//boolean topic5 = false;
//boolean topic6 = false;
//boolean topic7 = false;
//boolean topic8 = false;
//boolean topic9 = false;
//boolean topic10 = false;
//boolean topic11 = false;
//boolean topic12 = false;
//boolean topic13 = false;
//boolean topic14 = false;
//boolean topic15 = false;
//boolean topic16 = false;
//boolean topic17 = false;
//boolean topic18 = false;
//boolean topic19 = false;
//boolean topic20 = false;
//boolean topic21 = false;
//boolean topic22 = false;
//boolean topic23 = false;
//boolean topic24 = false;
//boolean topic25 = false;
//boolean topic26= false;
//boolean topic27 = false;
//boolean topic28 = false;
//boolean topic29 = false;
//boolean topic30 = false;
//boolean topic31 = false;
//boolean topic32 = false;
//boolean topic33 = false;
//boolean topic34 = false;
//boolean topic35 = false;
//boolean topic36 = false;
//boolean topic37 = false;

Table table;
int rowNums;
ArrayList<Book> books = new ArrayList<Book>();
float boxSize = 100;

PFont myTitleFont;
PFont myAxisFont;

boolean rot = false;
boolean mov = false;

//moving size
float moving = 1.0;
boolean movPos = true;

//dewey
String [] deweyRange = {"comp sci", "phil/psych", "religion", "soc sci", "language", "technology", "arts/rec", "literature", "hist/geog"};
//topic
String [] topicRange = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37"};
//year
String [] timeRange = {"2006", "2008", "2010", "2012", "2014", "2016"};

void setup() {
  size(1100, 800, P3D);
  smooth();
  cam = new PeasyCam(this, 230);
  cam.setMinimumDistance(50);        
  cam.setMaximumDistance(300); 
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);

  checkbox = cp5.addCheckBox("checkBox")
    .setPosition(900, 625)
    .setSize(10, 10)
    .setItemsPerRow(1)
    .setSpacingColumn(30)
    .setSpacingRow(10)
    .setColorLabel(color(255))

    .addItem("ALL TOPICS", 0)
    .addItem("AXES", 0)
    .addItem("LABELS", 50)
    .addItem("ROTATE", 100)
    ;

  checkbox1 = cp5.addCheckBox("checkBox1")
    .setPosition(50, 30)
    .setColorForeground(color(120))
    .setSize(10, 10)
    .setItemsPerRow(1)
    .setSpacingColumn(30)
    .setSpacingRow(10)
    .setColorLabel(color(235))

    .addItem("1: science record genealogical", 0)
    .addItem("2: business reference modern", 50)
    .addItem("3: engineering code handbook", 100)
    .addItem("4: architecture army city", 150)
    .addItem("5: years national complete", 200)
    .addItem("6: river valley story", 250)
    .addItem("7: music marine criticism", 0)
    .addItem("8: history seattle wash", 50)
    .addItem("9: bibliography biography women", 100)
    .addItem("10: art guide catalogs", 150)
    .addItem("11: travel guidebooks social", 200)
    .addItem("12: law legislation court", 250)
    .addItem("13: pacific coast geography", 0)
    .addItem("14: periodicals japanese ship", 50)
    .addItem("15: family descendants ancestors", 100)
    .addItem("16: medicine british catalogue", 150)
    .addItem("17: books encyclopedia international", 200)
    .addItem("18: american century literature", 250)
    .addItem("19: family account records", 0)
    .addItem("20: colleges student universities", 50)
    .addItem("21: handbook african americans", 100)
    .addItem("22: report south europe", 150)
    .addItem("23: england costume fashion", 200)
    .addItem("24: company life cooking", 250)
    .addItem("25: manual repair automobile", 150)
    .addItem("26: china civilization ancient ", 200)
    .addItem("27: history early making", 250)
    .addItem("28: exhibitions education island", 0)
    .addItem("29: america north indians", 50)
    .addItem("30: mass air human", 100)
    .addItem("31: washington puget region", 150)
    .addItem("32: war world civil", 200)
    .addItem("33: county history biographical", 250)
    .addItem("34: encyclopedias development house", 0)
    .addItem("35: design bible gold", 50)
    .addItem("36: dictionaries english language", 100)
    .addItem("37: history industry military", 150)
    ;

  myTitleFont = createFont("Roboto-Black.ttf", 4);
  myAxisFont = createFont("Roboto-Black.ttf", 3);
  table = loadTable("3_data.csv", "header");
  rowNums = table.getRowCount();
  //println("Rows: " + rowNums);

  //get table data
  for (int i=0; i<rowNums; i++) {
    int dewey = table.getInt(i, 0); // y axis
    String title = table.getString(i, 1); // mouse over
    String subject = table.getString(i, 2); 
    int date = table.getInt(i, 3); 
    int count = table.getInt(i, 4); // box width
    int days = table.getInt(i, 5); // x axis
    int topic = table.getInt(i, 6); // z axis; color
    String terms = table.getString(i, 8);

    books.add(new Book(dewey, title, subject, date, count, days, topic, terms));
  }

  //print row data
  //println("Number of Books: " + books.size());
  //println("Dewey: " +books.get(0).dewey);
  //println("Title: " +books.get(0).title);
  //println("Subject: " +books.get(0).subject);
  //println("Date: " +books.get(0).date);
  //println("Count: " +books.get(0).count);
  //println("Days: " +books.get(0).days);
  //println("Topic: " +books.get(0).topic);
  //println("Terms: " +books.get(0).terms);
}

void drawLabels() {
  textMode(SHAPE);
  // dewey class labels
  for (int c=0; c<6; c++) {
    textFont(myAxisFont);
    textAlign(LEFT, CENTER);
    //textMode(SHAPE);
    fill(#012E59);
    if (text1 == true) {
      pushMatrix();
      textSize(3);
      text(timeRange[c], (boxSize/6)*c-(boxSize/2), boxSize/2 + 20, boxSize/2);
      popMatrix();
    }
  }

  //dewey range labels
  for (int t=0; t<9; t++) {
    textFont(myAxisFont);
    textAlign(LEFT, CENTER);
    //textMode(SHAPE);
    fill(#012E59);
    if (text2 == true) {
      //pushMatrix();
      textSize(3);
      text(deweyRange[t], -boxSize/2 - 20, (-boxSize/9)*t+(boxSize/2)-10, boxSize/2);
      //popMatrix();
    }
  }

  // topic labels
  for (int d=0; d<37; d++) {
    textFont(myAxisFont);
    textAlign(LEFT, CENTER);
    fill(#012E59);
    if (text3 == true) {
      pushMatrix();
      text(topicRange[d], boxSize/2 + 30, boxSize/2, (boxSize/37)*d-(boxSize/2));
      popMatrix();
    }
  }

  // text title
  if (text4 == true) {
    textFont(myTitleFont);
    textAlign(LEFT, CENTER);
    fill(#012E59);
    //textMode(SHAPE);
    textFont(myAxisFont);
    text("TIME (2005-2017)", (boxSize/5)-(boxSize/2)+30, (-boxSize/10+boxSize/2)+20, boxSize/2);
    text("TOPIC (1-37)", boxSize/2+20, (-boxSize/10+boxSize/2), boxSize/2-55);
    textFont(myTitleFont);
    text("The  AUTODIDACT  DIARIES  |", -boxSize/2, boxSize/2 - 130, boxSize/2);
    text(" M259  |  Sara Lafia", -boxSize/2+57, boxSize/2 - 130, boxSize/2);
  }

  //saveFrame("export3.png");
}

void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void checkBox(float[] a) {
  println(a);
}
void draw() {

  if (cp5.getWindow().isMouseOver()) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
  background(#5D7B93);

  if (rot == true) {
    rotateY(frameCount*-0.001);
  }

  if (mov == true) {
    if (movPos == true) moving++;
    else moving --;
  }

  for (int i=0; i<books.size()-1; i++) {
    //x = date / 2005~2015 / 6 years / day-based
    float timeAxis = map(books.get(i).date, 38360, 42762, -boxSize/2, boxSize/2);
    //y = deweyclass / 1 - 999
    float deweyAxis = map(books.get(i).dewey, 0, 1000, -boxSize/2, boxSize/2);
    //z = topic / 1-37 
    float topicAxis = map(books.get(i).topic, 1, 37, -boxSize/2, boxSize/2);
    // float topicAxis = map(books.get(i).topic=1, 1, 37, -boxSize/2, boxSize/2);

    //unit width = checkout counts
    float countAxis = map(log(books.get(i).count), log(1), log(405990), 5, 300);
    //unit color = checkout counts
    //float colorAxis = map(log(books.get(i).count), log(1), log(405990), 0, 255);

    //unit color
    //colorMode(RGB);
    //color c = unitColor(books.get(i).dewey);

    colorMode(RGB, 370);
    // 1 - java
    if (data1 == true) {
      //float freq = map(Books.get(i).Google_java, (33), (96), 65, 235);
      //fill(#d53e4f, freq);
      // transforming coordinate system for each point
      pushMatrix();
      // origin at x, y, z (0,0,0)
      //translate(x1, y1, z);
      //point(0,0,0);
      // for loop 
      // curvePoint(Books.get(i).Google_java, (33), (96), 65, 235);
      // point(0,0,0);
      //if(lining == true){
      //  stroke(50);
      //  line(x1, y1, z, x1t, y1t, z);
      //}
      // curvePoint(0,0,0,0,0);
      // box(width, height, depth);
      // box height is function of SPL checkouts
      // box(3, 3, 3);
      //stroke(#d53e4f);

      popMatrix();
    }
    if (books.get(i).topic == 1) {
      //if (data1 == false)
      fill(10);
    } else if (books.get(i).topic == 2) {
      fill(20);
    } else if (books.get(i).topic == 3) {
      fill(30);
    } else if (books.get(i).topic == 4) {
      fill(40);
    } else if (books.get(i).topic == 5) {
      fill(50);
    } else if (books.get(i).topic == 6) {
      fill(60);
    } else if (books.get(i).topic == 7) {
      fill(70);
    } else if (books.get(i).topic == 8) {
      fill(80);
    } else if (books.get(i).topic == 9) {
      fill(90);
    } else if (books.get(i).topic == 10) {
      fill(100);
    } else if (books.get(i).topic == 11) {
      fill(110);
    } else if (books.get(i).topic == 12) {
      fill(120);
    } else if (books.get(i).topic == 13) {
      fill(130);
    } else if (books.get(i).topic == 14) {
      fill(140);
    } else if (books.get(i).topic == 15) {
      fill(150);
    } else if (books.get(i).topic == 16) {
      fill(160);
    } else if (books.get(i).topic == 17) {
      fill(170);
    } else if (books.get(i).topic == 18) {
      fill(180);
    } else if (books.get(i).topic == 19) {
      fill(190);
    } else if (books.get(i).topic == 20) {
      fill(200);
    } else if (books.get(i).topic == 21) {
      fill(210);
    } else if (books.get(i).topic == 22) {
      fill(220);
    } else if (books.get(i).topic == 23) {
      fill(230);
    } else if (books.get(i).topic == 24) {
      fill(240);
    } else if (books.get(i).topic == 25) {
      fill(250);
    } else if (books.get(i).topic == 26) {
      fill(260);
    } else if (books.get(i).topic == 27) {
      fill(270);
    } else if (books.get(i).topic == 28) {
      fill(280);
    } else if (books.get(i).topic == 29) {
      fill(290);
    } else if (books.get(i).topic == 30) {
      fill(230);
    } else if (books.get(i).topic == 31) {
      fill(310);
    } else if (books.get(i).topic == 32) {
      fill(320);
    } else if (books.get(i).topic == 33) {
      fill(330);
    } else if (books.get(i).topic == 34) {
      fill(340);
    } else if (books.get(i).topic == 35) {
      fill(350);
    } else if (books.get(i).topic == 36) {
      fill(360);
    } else if (books.get(i).topic == 37) {
      fill(370);
    }

    if (data1 == false) {
      pushMatrix();
      float[] rotations = cam.getRotations();
      translate(timeAxis, deweyAxis, topicAxis);
      box(1.5, 1.5, log(countAxis+moving)); //w, h, d
      //fill(c);
      strokeWeight(0.5);
      stroke(#012E59);
      float mouseObjectDistance = sq(mouseX-screenX(0, 0, 0))+sq(mouseY-screenY(0, 0, 0)); 
      if (mouseObjectDistance < 20)
      {
        rotateX(rotations[0]);
        rotateY(rotations[1]);
        rotateZ(rotations[2]);
        textSize(3);
        text(books.get(i).title.toUpperCase(), 0, 0);
      }
      popMatrix();
    }
  }

  // big box
  noFill();
  noStroke();
  box(boxSize);

  gui();
  drawLabels();
}
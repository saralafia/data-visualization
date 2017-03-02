//get max 
float max2D(float[][] array2D) {
  float max = 0;
  for (int i=0; i<array2D.length; i++) {
    for (int j=0; j<array2D[i].length; j++) {
      if (array2D[i][j] > max) {
        max = array2D[i][j];
      }
    }
  }
  return max;
}

// get min 
float min2D(float[][] array2D) {
  float max = max2D(array2D);
  float min = max;
  for (int i=0; i<array2D.length; i++) {
    for (int j=0; j<array2D[i].length; j++) {
      if (array2D[i][j] < min) {
        min = array2D[i][j];
      }
    }
  }
  return min;
}

// switch table to Google keyword frequency
void normalize() {
  // Google Keyword Search Table
  table = loadTable("multiTimelineGoogle.csv", "header");
  for (int i=0; i<numCols-2; i++)
  {
    for (int j=0; j<numRows; j++)
    {
      colorMode(HSB, 255);
      float freq = map(dataMatrix[i][j], minValue, maxValue, 65, 255);
      stroke(50);
      strokeWeight(0.2);
      
      if (i == 0) {
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
      pushMatrix();
      // rect(x, y, width, height, radius)
      rect(horMargin+cellWidth*j, verMargin+cellHeight*i+30, cellWidth, cellHeight-10, 1);
      popMatrix();
    }
  }

  maxValue = max2D(dataMatrix);
  minValue = min2D(dataMatrix);
}

// reset
void reset() {
  // restore original data table from Seattle Public Library
  table = loadTable("2a_Lafia.csv", "header");
  for (int i=0; i<numCols-2; i++) {
    for (int j=0; j<numRows; j++) {
      dataMatrix[i][j] = table.getFloat(j, i+2);
    }
  }
  maxValue = max2D(dataMatrix);
  minValue = min2D(dataMatrix);
}

// changes color ramp to "x-ray" grayscale to see through hue
float grayscale;
void colorscheme() {
  table = loadTable("2a_Lafia.csv", "header");
  for (int i=0; i<numCols-2; i++) {
    for (int j=0; j<numRows; j++) {
      stroke(255);
      strokeWeight(0.5);
      grayscale = map(dataMatrix[i][j], maxValue, minValue, 0, 255);
      fill(grayscale);
      rect(horMargin+cellWidth*j, verMargin+cellHeight*i+30, cellWidth, cellHeight-10, 1);
    }
  }
}
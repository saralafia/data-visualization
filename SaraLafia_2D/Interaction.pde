// keyboard function
void keyPressed()
{ 
  if (key == 'c' || key == 'C')
  {
    if (normalization == true) normalization = false;
    else if (normalization == false) normalization = true;
  }
  if (key == 'x' || key == 'X')
  {
    if (colorApply == true) colorApply = false;
    else if (colorApply == false) colorApply = true;
  }
}

// mouse function: need help with returning
/*void mousePressed() {
  
  for (int i=0; i<numRows-2; i++) {
    int checkoutMonth = table.getInt(i+1,0);
    // println(checkoutMonth);
    for (int j=0; j<numRows; j++) {
      if (mouseX>horMargin+cellWidth*j && mouseX<horMargin+cellWidth*(j+1) && mouseY>verMargin+cellHeight*i+30 && mouseY<verMargin+cellHeight*i+31)
      {
        textSize(15);
        textAlign(CENTER, BOTTOM);
        text(list.get(i).month,horMargin+cellWidth*j,horMargin+cellWidth*j);
      }
   
    
        
        text(checkoutMonth, mouseX, mouseY);
      }
    }
  } */
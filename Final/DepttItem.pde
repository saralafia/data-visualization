//DeptItem class visually controls each single department

class DeptItem extends SimpleMapItem { 
  String dept;
  float deptColor;
  
  DeptItem(String dept){
    this.dept = dept;
    deptColor = int(dept);
  }
    
  void draw(){
    //It controls colors of the tree map layers
    colorMode(HSB);
    stroke(50,100);
    if(deptColor != selectedDept) fill(map(deptColor, 0, 70, 0, 255), 255/2, 255/2, TRANS);
    else fill(map(deptColor, 0, 70,0, 255), 255/2, 255, TRANS*3);
    rect(x, y, w, h);
  }
}
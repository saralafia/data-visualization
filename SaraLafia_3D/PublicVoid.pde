public void controlEvent(ControlEvent c) {

  //checkbox
   if (c.isFrom(checkbox)) 
   {
    for (int i=0;i<checkbox.getArrayValue().length;i++) {
      int n = (int)checkbox.getArrayValue()[i];
      //print(n);
      if(i==0 && n==0) {
        data1 = false;}
      else if (i==0 && n==1){
        data1 = true;}
      if(i==1 && n==0) {
        text1 = false;
        text2 = false;
        text3 = false;
      }else if(i==1 && n==1) {
        text1 = true;
        text2 = true;
        text3 = true;
      }
      if(i==2 && n==0) {
        text4 = false;
      }else if(i==2 && n==1) {
        text4 = true;
      }
      if(i==3 && n==0) {
        rot = false;
      }else if(i==3 && n==1) {
        rot = true;
      }
    }
    //println();    
  }
  //if (c.isFrom(checkbox1)) 
  // {
  //  for (int i=0;i<checkbox.getArrayValue().length;i++) {
  //    int n = (int)checkbox.getArrayValue()[i];
  //    //print(n);
  //    if(i==0 && n==0) {
  //      topic1 = true;}
  //    else if (i==0 && n==1){
  //      topic1 = true;}
  //    if(i==1 && n==0) {
  //      topic2 = false;}
  //      else if (i==1 && n==1) {
  //      topic2 = true;}
       
  //}
}
//}
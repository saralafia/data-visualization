int startYear = 2005;
float dateParser(String rawDate){
  String[] dates = split(rawDate, '/');
  float parsedDate = (float(dates[0])-1)*30 + float(dates[1]) + (float(dates[2])-startYear)*365;
  return parsedDate;
}

float termParser(String rawTerm){
  String[] terms = split(rawTerm, ' ');
  float parsedTerm = float(terms[0]);
  return parsedTerm;
}

//void keyPressed() {
//    if(topic1 == false) topic1 = true;
//    else if(topic1 == true) topic1 = false;
  
//    if(topic2 == false) topic2 = true;
//    else if(topic2 == true) topic2 = false;
  
//    if(topic3 == false) topic3 = true;
//    else if(topic3 == true) topic3 = false;
  
//    if(topic4 == false) topic4 = true;
//    else if(topic4 == true) topic4 = false;
  
//    if(topic5 == false) topic5 = true;
//    else if(topic5 == true) topic5 = false;
  
//    if(topic6 == false) topic6 = true;
//    else if(topic6 == true) topic6 = false;
  
//  //checkbox
//  if (key==' ') {
//    checkbox.deactivateAll();
//  } 
//}
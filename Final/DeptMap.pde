//DeptMap class contains all DeptItems 

class DeptMap extends SimpleMapModel { 
  HashMap departments;
  
  DeptMap(){
    departments = new HashMap();
  }
  
  void addDepts(String dept, int count){
    DeptItem item = new DeptItem(dept);
    departments.put(dept, item);
    item.setSize(count);
  }
  
  void finishAdd(){
   items = new DeptItem[departments.size()];
   departments.values().toArray(items);
  }
}
class Document{
  
  String name;    
  int similarity;  
  //int lines;
  int words;
  
  ArrayList<Integer> chunks = new ArrayList<Integer>();
  ArrayList<Integer> collisions = new ArrayList<Integer>();
  
  Document(String bName){
    
    name = bName;
    
  }
  
}

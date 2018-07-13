
//parsing any document type to raw text, using tika api
String ParseDocument(File filename){
  
  println("Parsing Content of File: "+filename.getName());
  
   //File file = new File("angel.docx");
  //Instantiating Tika facade class
  Tika tika = new Tika();
  
  String filecontent="";
  try{
    filecontent = tika.parseToString(filename);
  }
  catch (TikaException e)
  {
    // Handle the error, or just print it, like:
    println("Error: " + e.getMessage());
  }
  catch (IOException e)
  {
    // Handle the error, or just print it, like:
    println("Error: " + e.getMessage());
  }
  
  //System.out.println("Extracted Content: " + filecontent); 
  
  return filecontent;
  
}

//generate the ngrams and hashcodes for checking 
void GenerateChunks(int i, File filename){
   
  println("Start GenerateChunks: File "+(i+1)+": "+filename.getName());
  
  Document bufDoc = new Document(filename.getName());
 
  String fullText = ParseDocument(filename);
  
  //sanitize text
  ArrayList<String> words = Ngrams.sanitiseToWords(fullText);
  
  //calculate n-grams by groups of 5 words
  ArrayList<String> ngrams = Ngrams.ngrams(words, 5);


  //hash ngrams
  for (String ngram: ngrams){
    
    //compute the ngram's hashcode
    Integer hashCode = ngram.hashCode();
                           
    if(ngramSet.contains(hashCode)){
      collisionSet.add(hashCode);        
    }else{
      ngramSet.add(hashCode);
    }
    
    //fill object chunck array
    bufDoc.chunks.add(hashCode);
       
  }
  
  //bufDoc.lines = lines.length;
  bufDoc.words = words.size();
  
  println("End GenerateChunks: File "+(i+1)+" words: "+words.size()+" chunks: "+ngrams.size());
  
  //store document data to arraylist
  documents.add(bufDoc);

  
}

//generate the ngrams and hashcodes for checking 
void CheckCollisions(int i, File filename){
   
  println("Start CheckCollisions: File "+(i+1)+": "+filename.getName());
 
  Document bufDoc = documents.get(i);
  
  //hash ngrams
  for (Integer chunk: bufDoc.chunks){
                        
    if(collisionSet.contains(chunk)){
      bufDoc.collisions.add(chunk); 
    }           
  }
  
  float similarity = ((float)bufDoc.collisions.size()/bufDoc.chunks.size())*100; 
  bufDoc.similarity = (int)similarity;
 
  println("End CheckCollisions: File "+(i+1)+" collisions: "+bufDoc.collisions.size()+" similarity: "+bufDoc.similarity+"%");
    
}


////generate the ngrams and hashcodes for checking 
//void ScanDocument(int i, File filename){
   
//  println("Scanning File "+(i+1)+": "+filename.getName());
  
//  Document bufDoc = new Document(filename.getName());
 
//  //load text by lines
//  //String[] lines = loadStrings(filename.getAbsolutePath());
//  //println(" -> There are " + lines.length + " lines.");        
//  //printArray(lines);
//  //concatenate lines
//  //String fullText = join(lines, " ");  
  
//  String fullText = ParseDocument(filename);
  
//  //sanitize text
//  ArrayList<String> words = Ngrams.sanitiseToWords(fullText);
//  //printArray(words);
  
//  //calculate n-grams by groups of 5 words
//  ArrayList<String> ngrams = Ngrams.ngrams(words, 5);
  
  
//  //System.out.println(ngrams.toString());
  
//  //create a hashmap to store de values
//  //HashMap<String,Integer> fileHashMap = new HashMap<String,Integer>();
  
  
//  //hash ngrams
//  for (String ngram: ngrams){
    
//    //compute the ngram's hashcode
//    Integer hashCode = ngram.hashCode();
                           
//    if(ngramSet.contains(hashCode)){
//      //println("Collision found in file "+(i+1)+" "+ngram);
//      collisionSet.add(hashCode);        
//    }else{
//      ngramSet.add(hashCode);
//    }
    
//    bufDoc.chunks.add(hashCode);
    
//    //insert the hashmap key and value
//    //fileHashMap.put(ngram, hashCode);  
//    //println("File "+i+" "+" Ngram "+ngrams.indexOf(ngram)+": "+hashCode+" -> "+ngram);          
//  }
  
//  float similarity = ((float)collisions/ngrams.size())*100;
  
//  bufDoc.similarity = (int)similarity;
//  //bufDoc.lines = lines.length;
//  bufDoc.words = words.size();
  
//  println("Results File "+(i+1)+" words: "+words.size()+" chunks: "+ngrams.size()+" collisions: "+collisions+" similarity: "+(int)similarity+"%");
  
//  //store document data to arraylist
//  documents.add(bufDoc);

  
//}

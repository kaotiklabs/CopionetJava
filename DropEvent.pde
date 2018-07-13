void dropEvent(DropEvent theDropEvent) { 
  
  if(theDropEvent.isFile()) {
    
    app_state = SCAN_APPSTATE;
    
    dropObject = theDropEvent.file(); 
    //println("\nisDirectory ? "+dropObject.isDirectory()+"  /  isFile ? "+dropObject.isFile()); 
    
    //if is a directory
    if(dropObject.isDirectory()) { 
      
      //println("listing the directory"); 
      filenames = dropObject.listFiles();
      println("Loading "+filenames.length+" files...\n");
      
      // GenerateChunks
      for (int i = 0; i < filenames.length; i++) {
        int percent = i*100/filenames.length;        
        println("Loading File "+(i+1)+" "+filenames[i].getName()+" loaded. "+percent+"% done");
        GenerateChunks(i, filenames[i]); 
      } //end file loop

      // CheckCollisions
      for (int i = 0; i < filenames.length; i++) {
        //int percent = i*100/filenames.length;        
        //println("Loading File "+(i+1)+" "+filenames[i].getName()+" loaded. "+percent+"% done");
        CheckCollisions(i, filenames[i]); 
      } //end file loop
      
    } //if is a directory 
    else{
      
      File bufFile = dropObject;      
      
      println("Loading file "+bufFile.getName()+" \n");
      GenerateChunks(0, bufFile);

      CheckCollisions(filenames.length, bufFile); 

      //// CheckCollisions
      //for (int i = 0; i < filenames.length; i++) {
      //  //int percent = i*100/filenames.length;        
      //  //println("Loading File "+(i+1)+" "+filenames[i].getName()+" loaded. "+percent+"% done");
      //  CheckCollisions(i, filenames[i]); 
      //} //end file loop
      
    }
    
    println("Total chunks: "+ngramSet.size());
    app_state = RESULTS_APPSTATE;
    
  } //if is a file
  else{      
    fill(0);
    textSize(24);
    text("ERROR: FILE FORMAT NOT RECOGNIZED", width/2, height*3/4); 
  }
} 

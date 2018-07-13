
void displayHomePage(){  
      fill(50, 96, 205);     
      textAlign(CENTER, CENTER);
      textSize(64);
      text("COPIONET", width/2+40, 60);
      fill(55, 110, 245);     
      textSize(24);
      text("The doc fraud detector", width/2+40, 100);
      
      fill(0);
      textSize(24);
      text("Drop a Folder with Docs", width/2, height*3/4);  
      
      image(logoImage, 160, 20);
      image(dropFolderImage, width/2-dropFolderImage.width/2, height/2-dropFolderImage.height/2);    
}

void displayResults(){
  
    if(documents!=null && documents.size() > 0){
    int barHeight = height/documents.size();

      if(mousePressed && (mouseButton == LEFT)){
        
         if(selectedDoc == -1){
           selectedDoc = mouseY/barHeight;
           
           println("Doc "+selectedDoc+" selected");
         }else{
          selectedDoc = -1; 
          println("No doc selected");
         }
          
         //app_state = DETAILS_APPSTATE; 
      }

    if(selectedDoc != -1){
      //draw selected border
      noStroke();
      fill(250);
      rect(0, selectedDoc*barHeight, width, barHeight);              
    }
            
    //loop all docs
    for (int i = 0; i < documents.size(); i++) {
      
      int chunks=documents.get(i).chunks.size();
      float chunkSize = (float)(width*2/3)/chunks;
      //int chunkSize = (int)((float)(width*2/3)/chunks); 
      

      //draw base blue bar                  
      noStroke();
      fill(55, 110, 245);
      rect(width/3-20, (i*barHeight)+barHeight/3, width*2/3, barHeight/3);
    
      strokeWeight(1); //necesari per arreglar el problema de pintar rects amb floats
      
      //loop all chunks in a doc
      for (int j = 0; j < chunks; j++) {
        //chunk color
        if(documents.get(i).collisions.contains(documents.get(i).chunks.get(j))){
          fill(254, 193, 32); //yellow
          stroke(254, 193, 32); //yellow                   
          rect(width/3+(j*chunkSize)-20, (i*barHeight)+barHeight/4, chunkSize, barHeight/2);
        }     
        
        if(selectedDoc != -1 && documents.get(selectedDoc).collisions.contains(documents.get(i).chunks.get(j))){
          fill(235, 86, 0); 
          stroke(235, 86, 0);                  
          //rect(width/3+(j*chunkSize)-20, i*barHeight+5, chunkSize, barHeight-10);           
          rect(width/3+(j*chunkSize)-20, (i*barHeight)+barHeight/4, chunkSize, barHeight/2);
        }
      }
       
      noStroke();
       
      if(documents.get(i).similarity >= 50){
        fill(235, 86, 0);  
      }else if(documents.get(i).similarity >= 15){
        fill(254, 193, 32);  
      }else{
        fill(55, 110, 245);
      }
      
      //draw small icon
      rect(0, (i*barHeight), 10, (i*barHeight)+barHeight);
      
      fill(0);
      textSize(18);
      textAlign(LEFT, CENTER);
      text(documents.get(i).similarity+"% coincident", 20, (i*barHeight)+barHeight/2);
      fill(255);
      textAlign(CENTER, CENTER);
      
      //chop string name if too long
      String name;
      if(documents.get(i).name.length()>35){
        name = documents.get(i).name.substring(0, 35)+"...";
      }else{
        name = documents.get(i).name;
      }
      
      text(name, width*2/3, (i*barHeight)+barHeight/2);
    }    
  }
  
}

void displayScan(){
  
  fill(50, 96, 205);     
  textAlign(CENTER, CENTER);
  textSize(64);
  text("COPIONET", width/2+40, 60);
  fill(55, 110, 245);     
  textSize(24);
  text("The doc fraud detector", width/2+40, 100);
            
  fill(0);
  textSize(24);
  text("Scanning "+documents.size()+" Docs ...", width/2, height*3/4);
  
  textSize(18);
  text("Unique chunks: "+ngramSet.size(), width/2, height*3/4+50);
  text("Collisions found: "+collisionSet.size(), width/2, height*3/4+80);
  
  float colRate = ((float)collisionSet.size()/ngramSet.size())*100;
  text("Collision Rate: "+(int)colRate+"%", width/2, height*3/4+110);
    
  image(logoImage, 160, 20);  
  image(dropFolderImage, width/2-dropFolderImage.width/2, height/2-dropFolderImage.height/2); 
  
  float dy = 80 * cos(TWO_PI * frameCount / 240);
  
  textSize(32);
  fill(200, 40, 40);
  int randNum = (int)random(10000000);
  text(randNum+""+randNum, width/2, height/2+32);
  
  strokeWeight(10);
  stroke(200, 40, 40);  
  line(width/2-150, height/2+30+dy, width/2+150, height/2+30+dy);
 
}


void displayDetails(){
    
  fill(50, 96, 205);     
  textAlign(CENTER, CENTER);
  textSize(64);
  text("COPIONET", width/2+40, 60);
  fill(55, 110, 245);     
  textSize(24);
  text("The doc fraud detector", width/2+40, 100);
            
  fill(0);
  textSize(24);
  text("Details "+selectedDoc, width/2, height*3/4);
  //text("Scanning "+documents.size()+" Docs ...", width/2, height*3/4);
  
  textSize(18);
  text("Unique chunks: "+ngramSet.size(), width/2, height*3/4+50);
  text("Collisions found: "+collisionSet.size(), width/2, height*3/4+80);
  
  float colRate = ((float)collisionSet.size()/ngramSet.size())*100;
  text("Collision Rate: "+(int)colRate+"%", width/2, height*3/4+110);
    
  image(logoImage, 160, 20);  
  image(dropFolderImage, width/2-dropFolderImage.width/2, height/2-dropFolderImage.height/2); 
  
  float dy = 80 * cos(TWO_PI * frameCount / 240);
  
  textSize(32);
  fill(200, 40, 40);
  int randNum = (int)random(10000000);
  text(randNum+""+randNum, width/2, height/2+32);
  
  strokeWeight(10);
  stroke(200, 40, 40);  
  line(width/2-150, height/2+30+dy, width/2+150, height/2+30+dy);
 
}


void displayExport(){
  
  fill(50, 96, 205);     
  textAlign(CENTER, CENTER);
  textSize(64);
  text("COPIONET", width/2+40, 60);
  fill(55, 110, 245);     
  textSize(24);
  text("The doc fraud detector", width/2+40, 100);
            
  fill(0);
  textSize(24);
  text("Scanning "+documents.size()+" Docs ...", width/2, height*3/4);
  
  textSize(18);
  text("Unique chunks: "+ngramSet.size(), width/2, height*3/4+50);
  text("Collisions found: "+collisionSet.size(), width/2, height*3/4+80);
  
  float colRate = ((float)collisionSet.size()/ngramSet.size())*100;
  text("Collision Rate: "+(int)colRate+"%", width/2, height*3/4+110);
    
  image(logoImage, 160, 20);  
  image(dropFolderImage, width/2-dropFolderImage.width/2, height/2-dropFolderImage.height/2); 
  
  float dy = 80 * cos(TWO_PI * frameCount / 240);
  
  textSize(32);
  fill(200, 40, 40);
  int randNum = (int)random(10000000);
  text(randNum+""+randNum, width/2, height/2+32);
  
  strokeWeight(10);
  stroke(200, 40, 40);  
  line(width/2-150, height/2+30+dy, width/2+150, height/2+30+dy);
 
}

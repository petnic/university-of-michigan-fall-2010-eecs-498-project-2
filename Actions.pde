class Actions {
  boolean added;
  boolean moved;
  boolean removed;
  
  int previousCount;
  int presentCount;
  
  int previousX;
  int presentX;
  int previousY;
  int presentY;
  
  int threshold;
  
  Actions () {
    added = false;
    moved = false;
    removed = false; 
   
    previousCount = 0;
    presentCount = 0; 
    
    previousX = 0;
    previousY = 0;
    presentX = 0;
    presentY = 0;
    
    threshold = 50;
  }
}

void colorAdded(int blockColor) {
  p.onAdd (blockColor);
}

void colorRemoved(int blockColor) {
  p.onRemove (blockColor);
}

void colorNothing(int blockColor) {
  p.onNothing (blockColor); 
}

void colorMoved(int blockColor) {
  p.onMove (blockColor);
}

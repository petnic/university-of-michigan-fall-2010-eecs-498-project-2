class Block {
  int like;
  Block() {
    like=0;
  }
}

class Personality{
  float[] reactMove;  // 0=like 1=dislike
  float[] reactAdd;
  float[] reactRemove;
  float[] reactNothing;
  Block[] blocks;
  
  Personality() {
    blocks=new Block[3];
    blocks[0]=new Block();
    blocks[1]=new Block();
    blocks[2]=new Block();
    reactMove=new float[2];
    reactAdd=new float[2];
    reactRemove=new float[2];
    reactNothing=new float[2];
  }
  
  void updatePers(){
    for (int i=0;i<3;i++) blocks[i].like=0;
    if (ptype == 1) {
      reactMove[0] = -70;
      reactAdd[0] = 100;
      reactRemove[0] = -150;
      reactNothing[0] = 4/1000;

      reactMove[1] = -20;
      reactAdd[1] = -150;
      reactRemove[1] = 100;
      reactNothing[1] = -4/1000;
    }
    if (ptype == 2) {
      // unique values for each personality
    }
    if (ptype == 3) {
      
    }
    if (ptype == 4) {
      
    }
    if (ptype == 5) {
      
    }
    if (ptype == 6) {
      
    }
    if (ptype == 7) {
      
    }
    if (ptype == 8) {
      
    }    
  }
  
  void onMove (int blockColor) {
    int bl = blocks[blockColor].like;
    if (bl < 0) {
      println("jkgkje");
      blocks[blockColor].like += reactMove[1];
    }
    else {
      
            println(reactMove[0]);
            println(ptype);
      blocks[blockColor].like += reactMove[0];
    }
    
    if (bl > 100) {
      blocks[blockColor].like = 100;
    }
    if (bl < -100) {
      blocks[blockColor].like =- 100;
    }

    println(blocks[blockColor].like);
    
    

    if (blocks[blockColor].like < 0) {
      if (blockColor==0)     Event_Speak(blocks[blockColor].like,6);//red
      if (blockColor==1)     Event_Speak(blocks[blockColor].like,7);//green
      if (blockColor==2)     Event_Speak(blocks[blockColor].like,8);//blue
    }
    else {
      Event_Speak(blocks[blockColor].like,1);//red
      
    }    
  
    
    
    
    Event_Speak(blocks[blockColor].like,1);
  }
  
  void onAdd (int blockColor) {
    int bl = blocks[blockColor].like;
    if (bl < 0) {
      blocks[blockColor].like += reactAdd[1];
    }
    else {
      blocks[blockColor].like += reactAdd[0];
    }
    
    if (bl > 100) {
      blocks[blockColor].like = 100;
    }
    if (bl < -100) {
      blocks[blockColor].like = -100;
    } 


    if (blocks[blockColor].like < 0) {
      if (blockColor==0)     Event_Speak(blocks[blockColor].like,3);//red
      if (blockColor==1)     Event_Speak(blocks[blockColor].like,4);//green
      if (blockColor==2)     Event_Speak(blocks[blockColor].like,5);//blue
    }
    else {
      if (blockColor==0)     Event_Speak(blocks[blockColor].like,9);//red
      if (blockColor==1)     Event_Speak(blocks[blockColor].like,10);//green
      if (blockColor==2)     Event_Speak(blocks[blockColor].like,11);//blue
      
    }    
  }  
  
  void onRemove (int blockColor) {
    int bl = blocks[blockColor].like;
    if (bl < 0) {
      blocks[blockColor].like += reactRemove[1];
    }
    else {
      blocks[blockColor].like += reactRemove[0];
    }
    
    if (bl > 100) {
      blocks[blockColor].like = 100;
    }
    if (bl < -100) {
      blocks[blockColor].like =- 100;
    }
    
    Event_Speak(blocks[blockColor].like,1);
  }
  
  void onNothing (int blockColor) {
    int bl = blocks[blockColor].like;
    if (bl < 0) {
      blocks[blockColor].like += reactNothing[1];
    }
    else {
      blocks[blockColor].like += reactNothing[0];
    }
    
    if (bl > 100) {
      blocks[blockColor].like = 100;
    }
    if (bl < -100) {
      blocks[blockColor].like = -100;
    } 
 //   Event_Speak(blocks[blockColor].like,0);
  }
};

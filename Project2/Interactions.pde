//keyPressed
void keyPressed() {
  if (key == '1') {
println("key=1");
    ptype = 1;
    p.updatePers();
  }
  if (key == '2') {
    ptype = 2;
        p.updatePers();
  }
  if (key == '3') {
    ptype = 3;
        p.updatePers();
  }
  if (key == '4') {
    ptype = 4;
        p.updatePers();
  }
  if (key == '5') {
    ptype = 5;
        p.updatePers();
  }
  if (key == '6') {
    ptype = 6;
        p.updatePers();
  }
  if (key == '7') {
    ptype = 7;
        p.updatePers();
  }
  if (key == '8') {
    ptype = 8;
        p.updatePers();
  }
  
  if (key == 'r' || key == 'R') {
    calibrationKey = 0;
  }
  if (key == 'g' || key == 'G') {
    calibrationKey = 1;
  }
  if (key == 'b' || key == 'B') {
    calibrationKey = 2;
  }
  
  if (key == '+' || key == '=') {
      switch (calibrationKey) {
        case 0:
            if (redThreshold < 255) {
              redThreshold++;
            }
          break;
        case 1:
          if (greenThreshold < 255) {
            greenThreshold++;
          }
          break;
        case 2:
          if (blueThreshold < 255) {
            blueThreshold++;
          }
          break;
        default:
          break;  
      }
  }
  
  if (key == '-' || key == '_') {
      switch (calibrationKey) {
        case 0:
            if (redThreshold > 0) {
              redThreshold--;
            }
          break;
        case 1:
          if (greenThreshold > 0) {
            greenThreshold--;
          }
          break;
        case 2:
          if (blueThreshold > 0) {
            blueThreshold--;
          }
          break;
        default:
          break;  
      }    
  }
}

//mousePressed
void mousePressed() {
  color temporaryColor = colorFilter.get(mouseX, mouseY);
  
  switch (calibrationKey) {
    case 0:
      if (red(temporaryColor) >= green(temporaryColor) && red(temporaryColor) >= blue(temporaryColor)) {
        println("redValue Calibrated");
        redValue = temporaryColor;
      }
      else {
        println("redValue Not Calibrated");  
      }
      break;
    case 1:
      if (green(temporaryColor) >= red(temporaryColor) && green(temporaryColor) >= blue(temporaryColor)) {
        println("greenValue Calibrated");
        greenValue = temporaryColor;
      }
      else {
        println("greenValue Not Calibrated");  
      }
      break;
    case 2:
      if (blue(temporaryColor) >= red(temporaryColor) && blue(temporaryColor) >= green(temporaryColor)) {
        println("blueValue Calibrated");
        blueValue = temporaryColor;
      }
      else {
        println("blueValue Not Calibrated");  
      }
      break;
    default:
      break;  
  }  
}

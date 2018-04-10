class Maps{
  // DATA FIELDS:
  private int level;
  private int w, h;   // Variables for the width and height of the play area
  private boolean first_load;
  private PFont font;
  
  // CONSTRUCTORS:
  // Default constructor
  Maps() {
    level = 1;
    first_load = true;
    w = width;
    h = height-100;
    
    font = loadFont("OCRAExtended-48.vlw");
  }
   
    
  // METHODS:
  // Method for drawing options bar displayed at the bottom of every map
  void display_menubar() {
    background(70, 173, 212);
    
    // Display score
    fill(0);
    textFont(font, 28);
    textAlign(LEFT, CENTER);
    text("SCORE: ", 50, height-50);
    
    // Display item slot
    text("ITEM:", width/2-80, height-50);
    rectMode(CENTER);
    noFill();
    stroke(3);
    rect(width/2+40, height-50, 50, 50);
    
    // Display exit button
    fill(255);
    rect(width-100, height-50, 100, 50);
    fill(0);
    textAlign(CENTER, CENTER);
    text("EXIT", width-100, height-50);
  }
  
  
  // Method for drawing generic play area for backdrop of every level
  void display_playarea(){
     // Draw playing area
    fill(25);
    stroke(1);
    rectMode(CORNER);
    rect(0, 0, width, height-100);
    
    // Draw grid
    stroke(100);
    for(float x = 0; x < w; x += 100)
      line(x, 0, x, h);
      
    for(float y = 0; y < h; y += 100)
      line(0, y, w, y);
      
    for(float x = 0; x < w; x += 100)
      for(float y = 0; y < h; y += 100)
        if(x != 0 && y != 0)
          ellipse(x, y, 5, 5); 
  }
  
  void draw_map(int level) {
   // Error checking to ensure a proper level is passed in 
   if(level > 6 || level < 1) 
     return;
     
   // Switch statement to draw the proper map
   switch(level){
     case 1: { display_level1(); break; }
     case 2: { display_level2(); break; }
     case 3: { display_level3(); break; }
     case 4: { display_level4(); break; }
     case 5: { display_level5(); break; }
     case 6: { display_level6(); break; }
     default: { display_level1(); break; }
   }
  }
  
  
  // Method for displaying map for level 1
  void display_level1(){
     display_menubar();
     display_playarea();
  }
    
    
  // Method for displaying map for level 2
  void display_level2(){
    display_menubar();
    display_playarea();
    
    fill(175);
    noStroke();
    rectMode(CORNERS);
    rect(0, h/2-50, w/5, h/2+50);
    rect(2*w/5, h/2-50, 3*w/5, h/2+50);
    rect(4*w/5, h/2-50, w, h/2+50);
  }
  
  
  // Method for displaying map for level 3
  void display_level3(){
    display_menubar();
    display_playarea();
    
    fill(175);
    noStroke();
    rectMode(CORNER);
    rect(0, h/2-25, w/4, 50);
    rect(w, h/2-25, -w/4, 50);
    rect(w/2-25, h, 50, -w/4);
    rect(w/2-25, 0, 50, w/4);
  }
  
  // Method for displaying map for level 4
  void display_level4(){
    display_menubar();
    display_playarea();
    
    fill(175);
    noStroke();
    ellipseMode(RADIUS);
    ellipse(w/2, h/2, 100, 100);
  }
  
  // Method for displaying map for level 5
  void display_level5(){
    display_menubar();
    display_playarea();
    
    fill(175); 
    noStroke();
    rectMode(CORNER);
    rect(100, 100, 50, 125);
    rect(100, 100, 200, 50);
    
    rect(100, h-100, 50, -125);
    rect(100, h-100-50, 200, 50);
    
    rect(w-100, 100, -50, 125);
    rect(w-100, 100, -200, 50);
    
    rect(w-100, h-100, -50, -125);
    rect(w-100, h-100-50, -200, 50);
  }
  
  // Method for displaying map for level 6
  void display_level6(){
    display_menubar();
    display_playarea();
    
    rectMode(CORNER);
    noStroke();
    fill(175);
    rect(w/4-25, 0, 50, 300);
    rect(w/4-25, h, 50, -100);
    
    rect(2*w/4-25, 0, 50, 150);
    rect(2*w/4-25, h, 50, -250);
    
    rect(3*w/4-25, 0, 50, 200); 
    rect(3*w/4-25, h, 50, -200);
  }
  
  // Boolean method to return whether the exit button the menu bar was clicked or not
  boolean mousepressed_menubar() {
    if(mouseX > width-100-100/2 && mouseX < width-100+100/2 && mouseY > height-50-50/2 && mouseY < height-50+50/2)
      return true;
    else 
      return false;
  }
 
}
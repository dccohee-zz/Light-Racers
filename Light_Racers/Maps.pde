class Maps{
  // DATA FIELDS:
  private int level;
  private int w, h;   // Variables for the width and height of the play area
  private PFont font;
  
  private Minim minim;
  private AudioPlayer curr_song, song1, song2, song3;
  
  // CONSTRUCTORS:
  // Default constructor
  Maps() {
    // Load all songs to be used in game
    minim = new Minim(Light_Racers.this);
    song1 = minim.loadFile("Derezzed.mp3");
    song2 = minim.loadFile("Tron Legacy (End Titles).mp3");
    song3 = minim.loadFile("The Game Has Changed.mp3");
    curr_song = song1;
      
    level = 1;
    w = width;
    h = height-100;
    
    font = loadFont("OCRAExtended-48.vlw");
  }
   
    
  // METHODS:
  // Accessors and Mutators for data fields:
  // Getter/Setter for game level
  void set_level(int level) { this.level = level; }
  int get_level() { return this.level; }
  
  // Getters for width and height
  int get_w() { return this.w; }
  int get_h() { return this.h; }
  
    
  // Getter/setter for song
  void get_song() { curr_song.play(); }    // (Getter only plays song instead of returning the song)
  void set_song(int choice) 
  { 
    // Validate that song choice passed in is within expected parameters
    if(choice < 1 || choice > 3)
      return;
       
     // Switch statement to change song based on choice
     switch(choice) {
      case 1: { curr_song = song1; break; }
      case 2: { curr_song = song2; break; }
      case 3: { curr_song = song3; break; }
     }
  }
    
  void stop_song() {
    curr_song.pause();
    curr_song.rewind();
  }
  
  void play_song() {
    curr_song.play(); 
  }
  
  
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
  
  // Method for displaying results green at the end of a round
  void display_endgame(){
    rectMode(CORNERS);
    fill(100, 100);
    rect(20, 20, width-20, height-20);
  }
  
  // Method for drawing the current level that has been selected
  void display_map(){
   // Of all possible maps, draw the one that has been selected
   switch(level){
    case 1: { display_level1(); break; }
    case 2: { display_level2(); break; }
    case 3: { display_level3(); break; }
    case 4: { display_level4(); break; }
    case 5: { display_level5(); break; }
    case 6: { display_level6(); break; }     
   }  
  }
  
  // Method for displaying map for level 1
  void display_level1(){
     play_song();
     display_menubar();
     display_playarea();
  }
    
    
  // Method for displaying map for level 2
  void display_level2(){
    play_song();
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
    play_song();
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
    play_song();
    display_menubar();
    display_playarea();
    
    fill(175);
    noStroke();
    ellipseMode(RADIUS);
    ellipse(w/2, h/2, 100, 100);
  }
  
  // Method for displaying map for level 5
  void display_level5(){
    play_song();
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
    play_song();
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
    
  // Method for alerting the light trails array of the obsticals contained within level 2. It inputs the light trail array and the width of the car (taken into account when calculating obstical parameters). 
  void set_level2_obsticals(boolean[][] light_trails, int car_width){
    // Loop through all obsticals and indicate in the array that those positions are occupied by an obstical    
    for(int x = 0-car_width; x < w/5+car_width; ++x)
      for(int y = h/2-50-car_width; y < h/2+50+car_width; ++y)
        // Ensure that the position calculated is valid within the array bounds
        if(x > 0 && x < w && y > 0 && y < h)
          light_trails[x][y] = true;
    
    for(int x = 2*w/5-car_width; x < 3*w/5+car_width; ++x)
      for(int y = h/2-50-car_width; y < h/2+50-car_width; ++y)
        // Ensure that the position calculated is valid within the array bounds
        if(x > 0 && x < w && y > 0 && y < h)
          light_trails[x][y] = true;
          
    for(int x = 4*w/5-car_width; x < w+car_width; ++x)
      for(int y = h/2-50-car_width; y < h/2+50+car_width; ++y)
         // Ensure that the position calculated is valid within the array bounds
         if(x > 0 && x < w && y > 0 && y < h)
          light_trails[x][y] = true;
  }
  
  
  // Method for alerting the light trails array of the obsticals contained within level 5. It inputs the light trail array and the width of the car (taken into account when calculating obstical parameters).
  void set_level3_obsticals(boolean[][] light_trails, int car_width){
    // Left side obstical 
    for(int x = 0-car_width; x < w/4+car_width; ++x)
      for(int y = h/2-25-car_width; y < h/2+25+car_width; ++y) 
        // Check that calculated position is within the bounds of the array
        if(x > 0 && y > 0 && x < w && y < h)  
          light_trails[(int)x][(int)y] = true;  
      
    // Right side obstical
    for(int x = w+car_width; x > w-w/4-car_width; --x)
      for(int y = h/2-25-car_width; y < h/2+25+car_width; ++y)
        // Check that calculated position is within the bounds of the array
        if(x > 0 && y > 0 && x < w && y < h)  
          light_trails[(int)x][(int)y] = true;  
          
    // Bottom obstical
    for(int x = w/2-25-car_width; x < w/2+25+car_width; ++x)
      for(int y = h+car_width; y > h-w/4-car_width; --y)
         // Check that calculated position is within the bounds of the array
        if(x > 0 && y > 0 && x < w && y < h)  
          light_trails[(int)x][(int)y] = true;  
  
    // Top obstical 
    for(int x = w/2-25-car_width; x < w/2+25+car_width; ++x)
      for(int y = 0-car_width; y < w/4+car_width; ++y)
         // Check that calculated position is within the bounds of the array
        if(x > 0 && y > 0 && x < w && y < h)  
          light_trails[(int)x][(int)y] = true;         
  }
  
  
  // Method for alerting the light trails array of the obsticals contained within level 5. It inputs the light trail array and the width of the car (taken into account when calculating obstical parameters). 
  void set_level4_obsticals(boolean[][] light_trails, int car_width){    
    // Iterate through the circle obstical and alert light_trails array of its presence 
    // First loop to iterate through every layer of the radius (0-100)
    for(int radius = 0; radius < 100+car_width; ++radius) {
      // Second loop to iterate around the circle
      for(float angle = 0; angle < 360; ++angle) {
        // Obtain the x-y coordinates around the radius of the circle
        float x = radius*sin((radians(angle)))+w/2;   
        float y = radius*cos((radians(angle)))+h/2;
        
        // Check that calculated position is within the bounds of the array
        if(x > 0 && y > 0 && x < w && y < h)  
          light_trails[(int)x][(int)y] = true;  
      }
    }
  }
  
  // Method for alerting the light trails array of the obsticals contained within level 5. It inputs the light trail array and the width of the car (taken into account when calculating obstical parameters). 
  void set_level5_obsticals(boolean[][] light_trails, int car_width){
    // Upper left corner obstical 
    for(int x = 100-car_width; x < 150+car_width; ++x)
      for(int y = 100-car_width; y < 225+car_width; ++y)
         if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
          light_trails[x][y] = true;
 
    for(int x = 100-car_width; x < 300+car_width; ++x)
      for(int y = 100-car_width; y < 150+car_width; ++y)
         if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
          light_trails[x][y] = true;
         
          
    // Lower left corner obstical 
    for(int x = 100-car_width; x < 150+car_width; ++x)
      for(int y = h-100+car_width; y > h-225-car_width; --y)
         if(x > 0 && x < w && y > 0 && y < h)  // Ensure that position being iterated through is within the bounds of the array
          light_trails[x][y] = true;
  
    for(int x = 100-car_width; x < 300+car_width; ++x)
        for(int y = h-150-car_width; y < h-100+car_width; ++y)
           if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
            light_trails[x][y] = true;
            
            
    // Upper right corner obstical
    for(int x = w-100+car_width; x > w-150-car_width; --x)
      for(int y = 100-car_width; y < 225+car_width; ++y)
         if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
          light_trails[x][y] = true;

    for(int x = w-100+car_width; x > w-300-car_width; --x)
      for(int  y= 100-car_width; y < 150+car_width; ++y)
         if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
          light_trails[x][y] = true;
      
      
    // Lower right corner obstical 
    for(int x = w-100+car_width; x > w-150-car_width; --x)
      for(int y = h-100+car_width; y > h-225-car_width; --y)
         if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
          light_trails[x][y] = true;
  
    for(int x = w-100+car_width; x > w-300-car_width; --x)
      for(int y = h-150-car_width; y < h-100+car_width; ++y)
         if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
            light_trails[x][y] = true;
           
   }
  
  void set_level6_obsticals(boolean[][] light_trails, int car_width){
    // Far left column obstical
    for(int x = w/4-25-car_width; x < w/4+25+car_width; ++x)
      for(int y = 0-car_width; y < 300+car_width; ++y)         
        if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
            light_trails[x][y] = true;
                    
    for(int x = w/4-25-car_width; x < w/4+25+car_width; ++x)
      for(int y = h+car_width; y > h-100-car_width; --y)
         if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
            light_trails[x][y] = true;

    // Middle column obstical 
    for(int x = 2*w/4-25-car_width; x < 2*w/4+25+car_width; ++x)
      for(int y = 0-car_width; y < 150+car_width; ++y)
          if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
            light_trails[x][y] = true;
    
    for(int x = 2*w/4-25-car_width; x < 2*w/4+25+car_width; ++x) 
      for(int y = h+car_width; y > h-250-car_width; --y) 
        if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
            light_trails[x][y] = true;
            
   // Far right column obstical
    for(int x = 3*w/4-25-car_width; x < 3*w/4+25+car_width; ++x) 
      for(int y = 0-car_width; y < 200+car_width; ++y) 
        if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
            light_trails[x][y] = true;
            
    for(int x = 3*w/4-25-car_width; x < 3*w/4+25+car_width; ++x) 
      for(int y = h+car_width; y > h-200-car_width; --y) 
        if(x > 0 && x < w && y > 0 && y < h)   // Ensure that position being iterated through is within the bounds of the array
            light_trails[x][y] = true;
  }  
  
   // Boolean method to return whether the exit button the menu bar was clicked or not
  void mousepressed_menubar() {
    if(mouseX > width-100-100/2 && mouseX < width-100+100/2 && mouseY > height-50-50/2 && mouseY < height-50+50/2)
      display_endgame();
  }
  
  // Function for checking if a car's position has gone outside the boundaries of the wall
  boolean check_wall(int x, int y, int car_width){
    if(x < 0+car_width || x > w-car_width)  
      return true;
    else if(y < 0+car_width || y > h-car_width)
      return true;
    else 
      return false;
  }
 
 }
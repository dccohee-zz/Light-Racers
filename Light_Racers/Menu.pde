class Menu {
   // DATA FIELDS:
   // Data fields required for audio
   private Minim minim;
   private AudioPlayer curr_song, song1, song2, song3;  
   
   private String selection;   // Variable to keep track of menu screen being displayed
   private boolean first_load;   // Boolean variable to notify when new screen is being loaded for first time
   private PImage background;   // Background image for each screen
   private PFont font;   // Text on UI screens
 
   
   // CONSTRUCTORS:
   // Default constructor
   Menu() { 
     selection = "menu";
     font = loadFont("OCRAExtended-48.vlw");
     first_load = true;
     
     minim = new Minim(Light_Racers.this);
     song1 = minim.loadFile("The Son of Flynn.mp3");
     song2 = minim.loadFile("Solar Sailer.mp3");
     song3 = minim.loadFile("End of Line.mp3");
     
     curr_song = song1;
     curr_song.loop();
   }
      
   // METHODS:
   // Accessors and mutators for data fields
   // Getter/Setter for selection
   String get_selection() { return selection; }
   void set_selection(String selection) { this.selection = selection; } 
   
   // Getter/setter for first load
   boolean get_first_load() { return this.first_load; }
   void set_first_load(boolean first_load) { this.first_load = first_load; }
   
   // Method for drawing main menu
   void display_main_menu(){
     // Load image for instructions page
     background = loadImage("Menu.jpg");
     tint(225, 150);
     image(background, 0, 0);     
     
     // Check if menu is being loaded for the first time
     if(first_load) {
       // Check if another song is already playing
       if(curr_song.isPlaying()) {
         curr_song.pause();    // Pause current song before playing next one
         curr_song.rewind();   // Rewind previous song for next plays
       }
         
       curr_song = song1;
       curr_song.loop();   // Loop background music
       first_load = false;   // Prevent song from being loaded again
     }
    
     textFont(font, 60);   // Font for menu
     textAlign(CENTER, CENTER);   
     
     // Main title
     fill(255);
     text("LIGHT RACERS", width/2, 125); 
     
     // Play Game button
     rectMode(CENTER);
     strokeWeight(1);
     fill(255);
     rect(width/2, 300, 245, 70);
     fill(0);
     textSize(35);
     text("Play Game", width/2, 300);
     
     // Instructions button
     fill(255);
     rect(width/4, 400, 200, 50);
     textSize(25);
     fill(0);
     text("Instructions", width/4, 400);
     
     // Settings button
     fill(255);
     rect(width/4, 475, 200, 50);
     fill(0);
     text("Settings", width/4, 475);
     
     // Customize button
     fill(255);
     rect(3*width/4, 400, 200, 50);
     fill(0);
     text("Customize", 3*width/4, 400);
     
     // Scores button
     fill(255);
     rect(3*width/4, 475, 200, 50);
     fill(0);
     text("Scores", 3*width/4, 475);
     
     // Exit button
     fill(255);
     rect(width/2, 550, 200, 50);
     fill(0);
     text("Exit", width/2, 550);
   }
   
   
   // Method for drawing instructions menu
   void display_instructions(){    
     // Load image for instructions page
     background = loadImage("Instructions.jpg");
     tint(225, 150);
     image(background, 0, 0);
     
     // Screen header
     textFont(font, 50);
     textAlign(CENTER, CENTER);
     fill(255);
     text("INSTRUCTIONS", width/2, 75);
       
     // Back button
     ellipseMode(CENTER);
     ellipse(75, 75, 75, 75);
     
     strokeWeight(8);
     fill(0);
     line(95, 75, 55, 75);
     line(55, 75, 75, 55);
     line(55, 75, 75, 95);
     
     // Instruction body text
     textFont(font, 16);
     textAlign(LEFT);
     fill(255);
     text("Insert instructions here", 50, 150);
   }
   
   // Method for drawing the settings menu
   void display_settings(){
     // Load image for settings page
     background = loadImage("Settings.jpg");
     tint(225, 150);
     image(background, 0, 0);
     
     // Check if menu is being loaded for the first time
     if(first_load){
       // Check if another song is already playing
       if(curr_song.isPlaying()) {
         curr_song.pause();    // Pause current song before playing next one
         curr_song.rewind();   // Rewind previous song for next play
       }
         
       curr_song = song2;
       curr_song.loop();   // Loop background music
       first_load = false;   // Prevent song from being loaded again
     }
     
     // Screen header
     textFont(font, 50);
     textAlign(CENTER, CENTER);
     fill(255);
     text("SETTINGS", width/2, 75);
     
     // Back button
     ellipseMode(CENTER);
     ellipse(75, 75, 75, 75);   
     
     strokeWeight(8);
     fill(0);
     line(95, 75, 55, 75);
     line(55, 75, 75, 55);
     line(55, 75, 75, 95);
     
     // Draw number of possible players:
     textFont(font, 25);
     textAlign(RIGHT);
     fill(255);
     text("Players: ", width/4+25, 175);
     textAlign(CENTER);
     text("2", width/4+150, 175);
     text("3", width/4+300, 175);
     text("4", width/4+450, 175);
     
     // Bubbles to select option:
     fill(255);
     strokeWeight(3);
     ellipseMode(CENTER);
     ellipse(width/4+150, 200, 15, 15);
     ellipse(width/4+300, 200, 15, 15);
     ellipse(width/4+450, 200, 15, 15);
     
     
     // Draw possible items to use:    
     textAlign(RIGHT);
     text("Items: ", width/4+25, 300);
     textAlign(CENTER);
     text("Item1", width/4+100, 300);
     text("Item2", width/4+200, 300);
     text("Item3", width/4+300, 300);
     text("Item4", width/4+400, 300);
     text("Item5", width/4+500, 300);
     
     // Boxes to select option:
     rectMode(CENTER);
     rect(width/4+100, 325, 15, 15);
     rect(width/4+200, 325, 15, 15);
     rect(width/4+300, 325, 15, 15);
     rect(width/4+400, 325, 15, 15);
     rect(width/4+500, 325, 15, 15);
     
      
     // Show possible curr_songs to play with: 
     textAlign(RIGHT);
     text("curr_song: ", width/4+25, 425);
     textAlign(CENTER);
     text("curr_song1", width/4 + 150, 425);
     text("curr_song2", width/4 + 300, 425);
     text("curr_song3", width/4 + 450, 425);
    
     // Bubbles to select option:
     ellipse(width/4+150, 450, 15, 15);
     ellipse(width/4+300, 450, 15, 15);
     ellipse(width/4+450, 450, 15, 15);
     
     
     // Show possible difficulties:
     textAlign(RIGHT);
     text("Difficulty: ", width/4+25, 550);
     textAlign(CENTER);
     text("Easy", width/4+200, 550);
     text("Hard", width/4+400, 550);
   }
   
   
   // Method for displaying customization screen
   void display_customize(){
     // Load image for scores page
     background = loadImage("Customize.jpg");
     tint(200, 150);
     image(background, 0, 0);
     
     // If screen is being loaded for the first time, cue up music
     if(first_load) {
     // Check if another song is already playing
     if(curr_song.isPlaying()) {
       curr_song.pause();    // Pause current song before playing next one
       curr_song.rewind();  // Rewind previous song for next play
     }
      
       curr_song = song3;
       curr_song.loop();   // Loop background music
       first_load = false;   // Prevent song from being loaded again
     }
     
     
     // Screen header
     textFont(font, 50);
     textAlign(CENTER, CENTER);
     fill(255);
     text("CUSTOMIZE", width/2, 75);
     
     // Back button
     ellipseMode(CENTER);
     ellipse(75, 75, 75, 75);   
     
     strokeWeight(8);
     fill(0);
     line(95, 75, 55, 75);
     line(55, 75, 75, 55);
     line(55, 75, 75, 95);
    
     
   }
   
   // Method for displaying high scores screen
   void display_scores(){
     // Load image for scores page
     background = loadImage("Scores.jpg");
     tint(200, 150);
     image(background, 0, 0);
     
     // Screen header
     textFont(font, 50);
     textAlign(CENTER, CENTER);
     fill(255);
     text("HIGH SCORES", width/2, 75);
     
     // Back button
     ellipseMode(CENTER);
     ellipse(75, 75, 75, 75);   
     
     strokeWeight(8);
     fill(0);
     line(95, 75, 55, 75);
     line(55, 75, 75, 55);
     line(55, 75, 75, 95);
     
     fill(100, 100);
     rectMode(CORNERS);
     rect(50, 150, width-50, height-25);
     
     // Display rankings:
     textFont(font, 28);
     textAlign(LEFT);
     fill(255);
     for(int i = 1; i <= 10; ++i){
       text(Integer.toString(i) + ".", 75, 155 + 40*i);
     }
     
     // Display high scores:
     textAlign(RIGHT);
     for(int i = 1; i <= 10; ++i){
      text(Integer.toString((int)random(500)), width-75, 155 + 40*i);
     }
   }
 
 
   // Method for displaying maps for the user to select from
   void display_maps(){
      // Load image for settings page
     background = loadImage("Maps.jpg");
     tint(225, 150);
     image(background, 0, 0);
     
     // Screen header
     textFont(font, 50);
     textAlign(CENTER, CENTER);
     fill(255);
     text("MAPS", width/2, 75);
     
     // Back button
     ellipseMode(CENTER);
     ellipse(75, 75, 75, 75);   
     
     strokeWeight(8);
     fill(0);
     line(95, 75, 55, 75);
     line(55, 75, 75, 55);
     line(55, 75, 75, 95);
     
     // Draw maps to select from
     rectMode(CENTER);
     stroke(3);
     noFill();
     tint(255);
        
     // Draw map icons
     // Level 1175/2
     PImage map1 = loadImage("Level1.jpg");
     image(map1, width/4-50-200/2, 225-125/2, 200, 125);
     rect(width/4-50, 225, 200, 125);
     
     // Level 2
     PImage map2 = loadImage("Level2.jpg");
     image(map2, 2*width/4-200/2, 225-125/2, 200, 125);
     rect(2*width/4, 225, 200, 125);
     
     // Level 3
     PImage map3 = loadImage("Level3.jpg");
     image(map3, 3*width/4+50-200/2, 225-125/2, 200, 125);
     rect(3*width/4+50, 225, 200, 125);
     
     // Level 4
     rect(width/4-50, 425, 200, 125);     
     PImage map4 = loadImage("Level4.jpg");
     image(map4, width/4-50-200/2, 425-125/2, 200, 125);
     
     // Level 5
     PImage map5 = loadImage("Level5.jpg");
     image(map5, 2*width/4-200/2, 425-125/2, 200, 125);   
     rect(2*width/4, 425, 200, 125);
     
     // Level 6
     PImage map6 = loadImage("Level6.jpg");
     image(map6, 3*width/4+50-200/2, 425-125/2, 200, 125);
     rect(3*width/4+50, 425, 200, 125);  
     
     stroke(1);
     noTint();
     
     // Draw start button
     fill(175);
     rect(width/2, height-40, 175, 50);
     textFont(font, 30);
     textAlign(CENTER, CENTER);
     fill(0);
     text("Start", width/2, height-40);
   }
   
   // Simple method for stopping whatever song is being played by menu
   void curr_song_stop() { curr_song.pause(); curr_song.rewind(); }
   
   
   
   // Method for controlling what happens when a mouse is clicked on the menu page
   void mousepressed_menu(){
     // Play Game button is pressed
      if(mouseX < width/2+245/2 && mouseX > width/2-245/2 && mouseY > 300-70/2 && mouseY < 300+70/2)
        selection = "maps";
          
      // Instructions button is pressed
      else if(mouseX < width/4+200/2 && mouseX > width/4-200/2 && mouseY > 400-50/2 && mouseY < 400+50/2)
        selection = "instructions";
        
      // Settings button is pressed    
      else if(mouseX < width/4+200/2 && mouseX > width/4-200/2 && mouseY > 475-50/2 && mouseY < 475+50/2) {
        selection = "settings";
        first_load = true;
      }
        
      // Customize button is pressed
      else if(mouseX < 3*width/4+200/2 && mouseX > 3*width/4-200/2 && mouseY > 400-50/2 && mouseY < 400+50/2){
        selection = "customize";
        first_load = true;  
    }
  
      // Scores button is pressed    
      else if(mouseX < 3*width/4+200/2 && mouseX > 3*width/4-200/2 && mouseY > 475-50/2 && mouseY < 475+50/2)
        selection = "scores";
        
      // Exit button is pressed    
      else if(mouseX < width/2+200/2 && mouseX > width/2-200/2 && mouseY > 550-50/2 && mouseY < 550+50/2)
        selection = "exit";
   }
 
 
   // Method for controlling what happens when a mouse is clicked on the instructions page
   void mousepressed_instructions(){
       // Back button is pressed
      if(dist(mouseX, mouseY, 75, 75) < 75/2)
        selection = "menu";
   }
 
 
   // Method for controlling what happens when a mouse is clicked on the settings page
   void mousepressed_settings(){ 
      // Back button is pressed
      if(dist(mouseX, mouseY, 75, 75) < 75/2){
        selection = "menu";
        first_load = true;
      }
   }
   
   // Method for controlling what happens when a mouse is clicked on the scores page
   void mousepressed_scores(){
     // Back button is pressed
      if(dist(mouseX, mouseY, 75, 75) < 75/2)
        selection = "menu";
   }
   
   // Method for controlling what happens when a mouse is clicked on the maps page. The method returns a number corresponding to the level selected from this page. 
   // [1-6] corresponding to levels 1-6. 0 indicates the play button has been pressed. Any negative number indicates that all other events.
   int mousepressed_maps(){
      // Back button is pressed
      if(dist(mouseX, mouseY, 75, 75) < 75/2){
        selection = "menu";
        return -1;
      }
      
      // Map 1 is selected
      else if(mouseX > width/4-50-200/2 && mouseX < width/4-50+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2)
        return 1;
      
      // Map 2 is selected
      else if(mouseX > 2*width/4-200/2 && mouseX < 2*width/4+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2)
        return 2;
      
      // Map 3 is selected
      else if(mouseX > 3*width/4+50-200/2 && mouseX < 3*width/4+50+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2)
        return 3;
      
      // Map 4 is selected
      else if(mouseX > width/4-50-200/2 && mouseX < width/4-50+200/2 && mouseY > 225-425/2 && mouseY < 225+425/2)
        return 4;
      
      // Map 5 is selected
      else if(mouseX > 2*width/4-200/2 && mouseX < 2*width/4+200/2 && mouseY > 225-425/2 && mouseY < 225+425/2)     
        return 5;
      
      // Map 6 is selected
      else if(mouseX > 2*width/4-200/2 && mouseX < 2*width/4+200/2 && mouseY > 225-425/2 && mouseY < 225+425/2)
        return 6;
        
      // Start button is pressed
      else if(mouseX > width/2-175/2 && mouseX < width/2+175/2 && mouseY > height-40-50/2 && mouseY < height-40+50/2)
        return 0;
      
      else 
        return -1;
      
   }   
   
   // Method for controlling what happens when a mouse is clicked on the maps page
   void mousepressed_customize(){
      // Back button is pressed
      if(dist(mouseX, mouseY, 75, 75) < 75/2)
        selection = "menu";
         first_load = true;
   }
   
   // Method for controlling what happens when mouse clicks exit button
   void mousepressed_exit(){ exit(); }
}
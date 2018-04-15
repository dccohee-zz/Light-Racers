class Menu {
   // DATA FIELDS:
   // Data fields required for audio
   private Minim minim;
   private AudioPlayer curr_song, song1, song2, song3;  
   
   private String selection;   // Variable to keep track of menu screen being displayed
   private boolean first_load;   // Boolean variable to notify when new screen is being loaded for first time
   private PImage background;   // Background image for each screen
   private int map;    // Variable to track which map is selected
   private PFont font;   // Text on UI screens
   private PImage map1, map2, map3, map4, map5, map6;   // Variables to store images of all map options
   
   // Variables to store which button the mouse is hovering over
   private int hover_menu;
   private int hover_map;
   private int hover_customize;
   
   private int song_selection;   // Variable to track which song is selected from the settings screen
   private int num_players;   // Variable to track the number of players selected from the settings screen
   private boolean difficulty;   // Variable to track the difficulty selected from the settings screen
   private color color_selection;   // Variable to track the customization color of the user
    
   
   // CONSTRUCTORS:
   // Default constructor
   Menu() { 
     selection = "menu";
     font = loadFont("OCRAExtended-48.vlw");
     first_load = true;
     map = 1;
     
     // Load all songs to prevent lagging due to persistent reloading
     minim = new Minim(Light_Racers.this);
     song1 = minim.loadFile("The Son of Flynn.mp3");
     song2 = minim.loadFile("Solar Sailer.mp3");
     song3 = minim.loadFile("End of Line.mp3");
     
     // Load all images to prevent lagging due to persistent reloading
     map1 = loadImage("Level1.jpg");
     map2 = loadImage("Level2.jpg");
     map3 = loadImage("Level3.jpg");
     map4 = loadImage("Level4.jpg");
     map5 = loadImage("Level5.jpg");
     map6 = loadImage("Level6.jpg");
     
     song_selection = 1;
     num_players = 2;
     difficulty = false;
     color_selection = 1;
     
     hover_map = 1;
     hover_menu = 1;
     hover_customize = 1;     
         
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
   
   // Getter/setter for song selection
   int get_song_selection() { return this.song_selection; }
   void set_song_selection(int song_selection) { this.song_selection = song_selection; }
   
   // Getter/setter for number of players
   int get_num_players() { return this.num_players; }
   void set_num_players(int num_players) { this.num_players = num_players; }
   
   // Getter/setter for difficulty
   boolean get_difficulty() { return this.difficulty; }
   void set_difficulty (boolean difficulty) { this.difficulty = difficulty; }
   
   // Getter/setter for color
   color get_color() { return this.color; }
   void set_color(color c) { this.color_selection = color; }
   
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
     // Color outline based on mouse hover position
     if(hover_menu == 1)
       stroke(70, 173, 212);
     else 
       stroke(0);
     
     rectMode(CENTER);
     strokeWeight(3);
     fill(255);     
     rect(width/2, 300, 245, 70);
     fill(0);
     textSize(35);
     text("Play Game", width/2, 300);
     
     // Instructions button
     // Color outline based on mouse hover position
     if(hover_menu == 2)
       stroke(70, 173, 212);
     else 
       stroke(0);     
     
     fill(255);
     rect(width/4, 400, 200, 50);
     textSize(25);
     fill(0);
     text("Instructions", width/4, 400);
     
     // Settings button
     // Color outline based on mouse hover position
     if(hover_menu == 3)
       stroke(70, 173, 212);
     else 
       stroke(0);     

     fill(255);
     rect(width/4, 475, 200, 50);
     fill(0);
     text("Settings", width/4, 475);
     
     // Customize button
     // Color outline based on mouse hover position
     if(hover_menu == 4)
       stroke(70, 173, 212);
     else 
       stroke(0);     

     fill(255);
     rect(3*width/4, 400, 200, 50);
     fill(0);
     text("Customize", 3*width/4, 400);
     
     // Scores button
     // Color outline based on mouse hover position
     if(hover_menu == 5)
       stroke(70, 173, 212);
     else 
       stroke(0);     

     fill(255);
     rect(3*width/4, 475, 200, 50);
     fill(0);
     text("Scores", 3*width/4, 475);
     
     // Exit button
     // Color outline based on mouse hover position
     if(hover_menu == 6)
       stroke(70, 173, 212);
     else 
       stroke(0);     

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
     
     // Fill bubble of selected option for the number of players
     fill(0);
     ellipse(width/4+150*(num_players-1), 200, 5, 5);
     
     
     // Draw possible items to use:    
     textAlign(RIGHT);
     fill(255);
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
     text("Music: ", width/4+25, 425);
     textAlign(CENTER);
     text("Song 1", width/4 + 150, 425);
     text("Song 2", width/4 + 300, 425);
     text("Song 3", width/4 + 450, 425);
    
     // Bubbles to select option:
     ellipse(width/4+150, 450, 15, 15);
     ellipse(width/4+300, 450, 15, 15);
     ellipse(width/4+450, 450, 15, 15);
     
     // Fill bubble for the selected song
     fill(0);
     ellipse(width/4+song_selection*150, 450, 5, 5);  
     
     
     // Show possible difficulties:
     // Draw box highlighing selected difficulty
     fill(70, 173, 212);
     if(difficulty) 
       rect(width/4+400, 525, 100, 50);   // Draw box around 'Hard' difficulty if selected
     else
       rect(width/4+200, 525, 100, 50);   // Else, draw box around 'Easy' difficulty if selected
     
     textAlign(RIGHT, CENTER);
     fill(255);
     text("Difficulty: ", width/4+25, 525);
     textAlign(CENTER, CENTER);
     text("Easy", width/4+200, 525);
     text("Hard", width/4+400, 525);
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
     // Change outline of button based on mouse position
     if(hover_customize < 0)
       stroke(#46add4);
     else
       stroke(0);
   
     ellipseMode(CENTER);
     ellipse(75, 75, 75, 75);   
     
     strokeWeight(8);
     stroke(0);
     fill(0);
     line(95, 75, 55, 75);
     line(55, 75, 75, 55);
     line(55, 75, 75, 95);
     
     color[] customize_color = {color(0, 0, 255), #00FFFF, #39FF14, #228B22, #6816e0, #d526b5, #FD5F00, #F3F315};   // Color array to display colors user can choose from
     int count = 0;   // Variable to iterate through every color and display it
    
     rectMode(CENTER);
     // Draw grid of potential colors to choose from
     for(int y = 1; y <= 2; ++y)
       for(int x = 1; x <= 4; ++x){
          // Fill outline of box based on if it is selected
          if(color_selection == customize_color[count])
            stroke(#46add4);
          // Fill outline of box based on if it is hovered over
          else if(hover_customize == 4*(y-1) + x)
            stroke(255);
           else
             stroke(0);
         
          fill(customize_color[count++]);
          rect((width/5)*x, 125*y+200, 100, 100);
       }
   }
   
   void mouse_pressed_settings(){
    for(int y = 1; y <= 2; ++y)
      for(int x = 1; x <= 4; ++x){
        if(mouseX > (width/5)*x-50 && mouseX < (width/5)*x+50 && mouseY > 125*y+100 && mouseY < 125*y+300)
          color_selection = (y-1)*4 + x;
      }
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
     // Change outline based on mouse hover
     if(hover_map < 0)
       stroke(70, 173, 212);
     else
       stroke(0);       
     
     ellipseMode(CENTER);
     ellipse(75, 75, 75, 75);   
     
     strokeWeight(8);
     fill(0);
     stroke(0);
     line(95, 75, 55, 75);
     line(55, 75, 75, 55);
     line(55, 75, 75, 95);
     
     // Draw maps to select from
     rectMode(CENTER);
     noFill();
     tint(255);
        
     // Draw map icons
     // Level 1
     // If map has been selected, change outline
     if(map == 1)
       stroke(70, 173, 212);
     // Else, if map is being hovered over, change outline
     else if(hover_map == 1)
       stroke(255);
     else
       stroke(0);
     
     image(map1, width/4-50-200/2, 225-125/2, 200, 125);
     rect(width/4-50, 225, 200, 125);
     
     // Level 2
     // If map has been selected, change outline
     if(map == 2)
       stroke(70, 173, 212);
     // Else, if map is being hovered over, change outline
     else if(hover_map == 2)
       stroke(255);
     else
       stroke(0);
     
     image(map2, 2*width/4-200/2, 225-125/2, 200, 125);
     rect(2*width/4, 225, 200, 125);
     
     // Level 3
     // If map has been selected, change outline
     if(map == 3)
       stroke(70, 173, 212);
     // Else, if map is being hovered over, change outline
     else if(hover_map == 3)
       stroke(255);
     else
       stroke(0);
     
     image(map3, 3*width/4+50-200/2, 225-125/2, 200, 125);
     rect(3*width/4+50, 225, 200, 125);
     
     // Level 4
     // If map has been selected, change outline
     if(map == 4)
       stroke(70, 173, 212);
     // Else, if map is being hovered over, change outline
     else if(hover_map == 4)
       stroke(255);
     else
       stroke(0);
        
     image(map4, width/4-50-200/2, 425-125/2, 200, 125);
     rect(width/4-50, 425, 200, 125);  
     
     // Level 5
     // If map has been selected, change outline
     if(map == 5)
       stroke(70, 173, 212);
     // Else, if map is being hovered over, change outline
     else if(hover_map == 5)
       stroke(255);
     else
       stroke(0);
     
     image(map5, 2*width/4-200/2, 425-125/2, 200, 125);   
     rect(2*width/4, 425, 200, 125);
     
     // Level 6
     // If map has been selected, change outline
     if(map == 6)
       stroke(70, 173, 212);
     // Else, if map is being hovered over, change outline
     else if(hover_map == 6)
       stroke(255);
     else
       stroke(0);
     
     image(map6, 3*width/4+50-200/2, 425-125/2, 200, 125);
     rect(3*width/4+50, 425, 200, 125);  
     
     noTint();
     
     // Draw start button
     // Change outline based on mouse hover
     if(hover_map == 0)
       stroke(255);
     else
       stroke(0);
     
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
   
   
   // Method for detecting which button the mouse is hovering over on the menu screen. It contains no input nor output.
   void mouse_hover_menu(){
       if(mouseX < width/2+245/2 && mouseX > width/2-245/2 && mouseY > 300-70/2 && mouseY < 300+70/2)
         hover_menu = 1;
          
      // Instructions button is pressed
      else if(mouseX < width/4+200/2 && mouseX > width/4-200/2 && mouseY > 400-50/2 && mouseY < 400+50/2)
        hover_menu = 2;
        
      // Settings button is pressed    
      else if(mouseX < width/4+200/2 && mouseX > width/4-200/2 && mouseY > 475-50/2 && mouseY < 475+50/2) 
        hover_menu = 3;
        
      // Customize button is pressed
      else if(mouseX < 3*width/4+200/2 && mouseX > 3*width/4-200/2 && mouseY > 400-50/2 && mouseY < 400+50/2)
        hover_menu = 4;
  
      // Scores button is pressed    
      else if(mouseX < 3*width/4+200/2 && mouseX > 3*width/4-200/2 && mouseY > 475-50/2 && mouseY < 475+50/2)
        hover_menu = 5;
        
      // Exit button is pressed    
      else if(mouseX < width/2+200/2 && mouseX > width/2-200/2 && mouseY > 550-50/2 && mouseY < 550+50/2)
        hover_menu = 6;
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
      
      // Mouse pressed to change number of players
      if(dist(mouseX, mouseY, width/4+150, 200) < 15/2){
        num_players = 2;
      }
      else if(dist(mouseX, mouseY, width/4+300, 200) < 15/2){
        num_players = 3;
      }
      else if(dist(mouseX, mouseY, width/4+450, 200) < 15/2){
        num_players = 4;
      }
           
      // Mouse pressed to change song playing 
      if(dist(mouseX, mouseY, width/4+150, 450) < 15/2){
        song_selection = 1;
      }
      else if(dist(mouseX, mouseY, width/4+300, 450) < 15/2){
        song_selection = 2;
      }
      else if(dist(mouseX, mouseY, width/4+450, 450) < 15/2){
        song_selection = 3;
      }
      
     // Mouse pressed to change difficulty
     // Mouse pressed on hard difficulty 
     if(mouseX > width/4+350 && mouseX < width/4+450 && mouseY > 475 && mouseY < 575)
       difficulty = true;
     // Mouse pressed on easy difficulty
     else if(mouseX > width/4+150 && mouseX < width/4+250 && mouseY > 475 && mouseY < 575)
       difficulty = false;
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
      else if(mouseX > width/4-50-200/2 && mouseX < width/4-50+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2){
        map = 1;
        return 1;
      }
      
      // Map 2 is selected
      else if(mouseX > 2*width/4-200/2 && mouseX < 2*width/4+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2){
        map = 2;
        return 2;
      }
      
      // Map 3 is selected
      else if(mouseX > 3*width/4+50-200/2 && mouseX < 3*width/4+50+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2) {
        map = 3;
        return 3;
      }
      
      // Map 4 is selected
      else if(mouseX > width/4-50-200/2 && mouseX < width/4-50+200/2 && mouseY > 225-425/2 && mouseY < 225+425/2) {
        map = 4;
        return 4;
      }
      
      // Map 5 is selected
      else if(mouseX > 2*width/4-200/2 && mouseX < 2*width/4+200/2 && mouseY > 225-425/2 && mouseY < 225+425/2) {
        map = 5;
        return 5;
      }
      
      // Map 6 is selected
      else if(mouseX > 3*width/4-200/2 && mouseX < 3*width/4+200/2 && mouseY > 225-425/2 && mouseY < 225+425/2){
        map = 6;
        return 6;
      }
        
      // Start button is pressed
      else if(mouseX > width/2-175/2 && mouseX < width/2+175/2 && mouseY > height-40-50/2 && mouseY < height-40+50/2)
        return 0;
      
      else 
        return -1;
   }   
   
   // Method for changing the outline of an item when the mouse hovers over it in the maps screen
   void mouse_hover_maps(){ 
      // Hover over back button
      if(dist(mouseX, mouseY, 75, 75) < 75/2)
        hover_map = -1;
      
      // Hover over map 1
      else if(mouseX > width/4-50-200/2 && mouseX < width/4-50+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2)
        hover_map = 1;
      
      // Hover over map 2
      else if(mouseX > 2*width/4-200/2 && mouseX < 2*width/4+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2)
        hover_map = 2;
      
      // Hover over map 3
      else if(mouseX > 3*width/4+50-200/2 && mouseX < 3*width/4+50+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2)
        hover_map = 3;
      
      // Hover over map 4
      else if(mouseX > width/4-50-200/2 && mouseX < width/4-50+200/2 && mouseY > 425-125/2 && mouseY < 425+125/2)
        hover_map = 4;
      
      // Hover over map 5
      else if(mouseX > 2*width/4-200/2 && mouseX < 2*width/4+200/2 && mouseY > 425-125/2 && mouseY < 425+125/2)     
        hover_map = 5;
             
      // Hover over map 6
      else if(mouseX > 3*width/4-200/2 && mouseX < 3*width/4+200/2 && mouseY > 425-125/2 && mouseY < 425+125/2)
        hover_map = 6;
        
      // Hover over start button 
      else if(mouseX > width/2-175/2 && mouseX < width/2+175/2 && mouseY > height-40-50/2 && mouseY < height-40+50/2)
        hover_map = 0;
   }
   
   // Method for controlling what happens when a mouse is clicked on the maps page
   void mousepressed_customize(){
      // Back button is pressed
      if(dist(mouseX, mouseY, 75, 75) < 75/2){
        selection = "menu";
        first_load = true;
      }
      
      color[] customize_color = {color(0, 0, 255), #00FFFF, #39FF14, #228B22, #6816e0, #d526b5, #FD5F00, #F3F315};   // Color array of color choices user can choose from
      int index = 0;
      
      // Loop through each color option and see if any have been selected
      for(int y = 1; y <= 2; ++y)
        for(int x = 1; x <= 4; ++x){
          // Check if mouse click is within bounds of a particular box
          if(mouseX > (width/5)*x-50 && mouseX < (width/5)*x+50 && mouseY > 125*y+150 && mouseY < 125*y+250)
            color_selection = customize_color[index++];   // Set color selection to index if true
          else 
            ++index;
      }    
   }
   
   // Method for detecting when the mouse position is hovering over a specific item on the customization screen
   void mouse_hover_customize(){
      // If hovering over back button
      if(dist(mouseX, mouseY, 75, 75) < 75/2)
        hover_customize = -1;
      
      
      // If hovering over customization color
      for(int y = 1; y <= 2; ++y)
        for(int x = 1; x <= 4; ++x){
          if(mouseX > (width/5)*x-50 && mouseX < (width/5)*x+50 && mouseY > 125*y+150 && mouseY < 125*y+250)
            hover_customize = (y-1)*4 + x;   // Remember index of box being hovered over
      }    
   }
   
   // Method for controlling what happens when mouse clicks exit button
   void mousepressed_exit(){ exit(); }
}
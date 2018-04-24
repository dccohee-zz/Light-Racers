/*
Authors: Dalton Cale Cohee and Douglas Easom 
Date: 6 April 2018
Program: Light Racer: Menu
Program Description: This class is used to display all menu screens for the game. It also is used for switching from screen to screen and collecting all information that the user selects.  
*/

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
   private PImage music_pic, soundeffect_pic;   // Variable to stop clipart for volume button and sound effect button
      
   private int song_selection;   // Variable to track which song is selected from the settings screen
   private int num_players;   // Variable to track the number of players selected from the settings screen
   private boolean difficulty;   // Variable to track the difficulty selected from the settings screen
   private color player1_color, player2_color;   // Variable to track the customization color of the two users
   private int lives;   // Variable to track the number of lives for each car
   private boolean users;   // Variable to track the number of users in a game (1-player vs 2-player)
    
   private boolean music;   // Variable for controlling if music plays during the round
   private boolean sound_effect;   // Variable for controlling if sound effects play during the round 
   
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
     
     music_pic = loadImage("music.png");
     soundeffect_pic = loadImage("soundeffect.png");
     
     song_selection = 1;
     num_players = 2;
     difficulty = false;
     player1_color = color(0,0,255);
     player2_color = color(#00FFFF);
     lives = 1;
     users = false;
     
     music = true;
     sound_effect = true;
         
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
   color get_player1_color() { return this.player1_color; }
   void set_player1_color(color c) { this.player1_color = c; }
   
   color get_player2_color() { return this.player2_color; }
   void set_player2_color(color c) { this.player2_color = c; }
   
   // Getter/setting for map
   int get_map() { return this.map; }
   void set_map(int map) { this.map = map; }
   
   // Getter/setter for lives
   int get_lives() { return this.lives; }
   void set_lives(int lives) { this.lives = lives; }
   
   // Getter/setting for number of users
   boolean get_users() { return this.users; } 
   void set_users(boolean users) { this.users = users;  }
   
   // Getter/setter for play state
   boolean get_music() { return this.music; }
   void set_music(boolean music) { this.music = music; }
   
   // Getter/setter for sound effect state
   boolean get_sound_effect() { return this.sound_effect; }
   void set_sound_effect(boolean sound_effect) { this.sound_effect = sound_effect; }
   
   // Simple method for stopping whatever song is being played by menu
   void curr_song_stop() { curr_song.pause(); curr_song.rewind(); }
   
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
     if(mouseX < width/2+245/2 && mouseX > width/2-245/2 && mouseY > 300-70/2 && mouseY < 300+70/2)
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
     if(mouseX < width/4+200/2 && mouseX > width/4-200/2 && mouseY > 400-50/2 && mouseY < 400+50/2)
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
     if(mouseX < width/4+200/2 && mouseX > width/4-200/2 && mouseY > 475-50/2 && mouseY < 475+50/2) 
       stroke(70, 173, 212);
     else 
       stroke(0);     

     fill(255);
     rect(width/4, 475, 200, 50);
     fill(0);
     text("Settings", width/4, 475);
     
     // Customize button
     // Color outline based on mouse hover position
     if(mouseX < 3*width/4+200/2 && mouseX > 3*width/4-200/2 && mouseY > 400-50/2 && mouseY < 400+50/2)
       stroke(70, 173, 212);
     else 
       stroke(0);     

     fill(255);
     rect(3*width/4, 400, 200, 50);
     fill(0);
     text("Maps", 3*width/4, 400);
     
     // Scores button
     // Color outline based on mouse hover position
     if(mouseX < 3*width/4+200/2 && mouseX > 3*width/4-200/2 && mouseY > 475-50/2 && mouseY < 475+50/2)
       stroke(70, 173, 212);
     else 
       stroke(0);     

     fill(255);
     rect(3*width/4, 475, 200, 50);
     fill(0);
     text("Customize", 3*width/4, 475);
     
     // Exit button
     // Color outline based on mouse hover position
     if(mouseX < width/2+200/2 && mouseX > width/2-200/2 && mouseY > 550-50/2 && mouseY < 550+50/2)
       stroke(70, 173, 212);
     else 
       stroke(0);     

     fill(255);
     rect(width/2, 550, 200, 50);
     fill(0);
     text("Exit", width/2, 550);

     // Display music toggle button:
     // Change highlight based on mouse position
     if(dist(mouseX, mouseY, 40, height-40) < 50)
       stroke(70, 173, 212);
     else 
       stroke(0);
       
     fill(255);    
     ellipseMode(CENTER);
     ellipse(40, height-40, 50, 50);
     
     // Draw line through button if disabled
     if(!music) 
       line(25, height-55, 55, height-25);
       
     noTint();
     image(music_pic, 20, height-58, 35, 35); 
     
     // Display sound effect toggle button:
     // Change highlight based on mouse position
      if(dist(mouseX, mouseY, 100, height-40) < 50)
       stroke(70, 173, 212);
     else 
       stroke(0);
             
     fill(255);
     ellipse(100, height-40, 50, 50);
     
     // Draw line through button if disabled
     if(!sound_effect) 
       line(85, height-55, 115, height-25);
     
     image(soundeffect_pic, 83, height-58, 35, 35);
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
      // Change button highlight if mouse is hovering over 
     if(dist(mouseX, mouseY, 75, 75) < 75/2)
        stroke(70, 173, 212);
     else
        stroke(0); 
     strokeWeight(8);
     ellipseMode(CENTER);
     ellipse(75, 75, 75, 75);
     
     stroke(0);
     line(95, 75, 55, 75);
     line(55, 75, 75, 55);
     line(55, 75, 75, 95);
     
     rectMode(CORNERS);
     fill(100, 100);
     noStroke();
     rect(20, 120, width-20, height-25);
     
     // Instruction body text
     textFont(font, 20);
     textAlign(LEFT);
     fill(255);
     text(".:Game Play:.\nUp to 4 Players race around the map leaving a light trail\n behind. Players are eliminated when they come in contact \nwith other player’s trail or the walls of the map. When a \nplayer is eliminated their trial is removed from the map and \nthey are respawned back in there starting location. When a \nplayer’s lives total reaches zero they are removed from the \ngame. \nThe last player alive wins the game.\n\n.:Customization:.\nBefore the start of a game you may customize the game rules.\n\n Music – There are 3 options for in-game music.\n Racer Color – There are 8 different colors to choose from.\n Lives – There are three options for lives (1, 3, 5).\n Map – There are 6 different maps to choose from.\n Difficulty – Set to 'Beginner' by default. 'Normal' triples\n the racer's speed.\n Number of Players – 2, 3, or 4 players can play in a round.\n Number of Users - Rounds can be 1-Player or 2-Player.", 40, 150);
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
     // Change button highlight if mouse is hovering over 
     if(dist(mouseX, mouseY, 75, 75) < 75/2)
        stroke(70, 173, 212);
     else
        stroke(0); 
      
     strokeWeight(8);   
     ellipseMode(CENTER);
     ellipse(75, 75, 75, 75);   
     
     stroke(0);
     line(95, 75, 55, 75);
     line(55, 75, 75, 55);
     line(55, 75, 75, 95);
     
     // Draw number of possible players:
     textFont(font, 25);
     textAlign(RIGHT);
     fill(255);
     text("Players: ", width/4+25, 150);
     textAlign(CENTER);
     text("2", width/4+150, 150);
     text("3", width/4+300, 150);
     text("4", width/4+450, 150);
     
     // Bubbles to select option:
     fill(255);
     strokeWeight(3);
     ellipseMode(CENTER);
     ellipse(width/4+150, 175, 15, 15);
     ellipse(width/4+300, 175, 15, 15);
     ellipse(width/4+450, 175, 15, 15);
     
     // Fill bubble of selected option for the number of players
     fill(0);
     ellipse(width/4+150*(num_players-1), 175, 5, 5);
     
     
     // Draw number of lives to choose from:   
     textAlign(RIGHT);
     fill(255);
     text("Lives: ", width/4+25, 250);
     textAlign(CENTER);
     text("1", width/4+150, 250);
     text("3", width/4+300, 250);
     text("5", width/4+450, 250);
     
     // Bubbles to select option of lives:
     rectMode(CENTER);
     ellipse(width/4+150, 275, 15, 15);
     ellipse(width/4+300, 275, 15, 15);
     ellipse(width/4+450, 275, 15, 15);
     
     // Fill bubble of select option for number of lives
     int selection = 1;
     if(lives == 3) selection = 2;
     if(lives == 5) selection = 3;
     
     fill(0);
     ellipse(width/4+150*(selection), 275, 5, 5);
     
     // Display option to select one or two players
     textAlign(RIGHT);
     fill(255);
     text("Users: ", width/4+25, 350);
     
     fill(70, 173, 212);
     if(users) 
       rect(width/4+400, 350, 150, 50);   // Draw box around 2-Player if selected
     else
       rect(width/4+200, 350, 150, 50);   // Else, draw box around 1-Player if selected
     
     textAlign(CENTER, CENTER);
     fill(255);
     text("1-Player", width/4+200, 350);
     text("2-Player", width/4+400, 350);
     
     
     // Show possible songs to play with: 
     textAlign(RIGHT);
     fill(255);
     text("Music: ", width/4+25, 450);
     textAlign(CENTER);
     text("Song 1", width/4 + 150, 450);
     text("Song 2", width/4 + 300, 450);
     text("Song 3", width/4 + 450, 450);
    
     // Bubbles to select option of songs:
     ellipse(width/4+150, 475, 15, 15);
     ellipse(width/4+300, 475, 15, 15);
     ellipse(width/4+450, 475, 15, 15);
     
     // Fill bubble for the selected song
     fill(0);
     ellipse(width/4+song_selection*150, 475, 5, 5);  
     
     
     // Show possible difficulties:
     // Draw box highlighing selected difficulty
     fill(70, 173, 212);
     if(difficulty) 
       rect(width/4+400, 550, 150, 50);   // Draw box around 'Hard' difficulty if selected
     else
       rect(width/4+200, 550, 150, 50);   // Else, draw box around 'Easy' difficulty if selected
     
     textAlign(RIGHT, CENTER);
     fill(255);
     text("Difficulty: ", width/4+25, 550);
     textAlign(CENTER, CENTER);
     text("Beginner", width/4+200, 550);
     text("Normal", width/4+400, 550);
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
     // Change button highlight if mouse is hovering over 
     if(dist(mouseX, mouseY, 75, 75) < 75/2)
        stroke(70, 173, 212);
     else
        stroke(0); 
          
     strokeWeight(8);  
     ellipseMode(CENTER);
     ellipse(75, 75, 75, 75);   

     stroke(0);
     line(95, 75, 55, 75);
     line(55, 75, 75, 55);
     line(55, 75, 75, 95);
     
     color[] customize_color = {color(0, 0, 255), #00FFFF, #39FF14, #228B22, #6816e0, #d526b5, #FD5F00, #F3F315};   // Color array to display colors user can choose from
     int count = 0;   // Variable to iterate through every color and display it
     
     // Display colors for player 1:
     textSize(28);
     text("Player 1:", width/2, 125);
    
     rectMode(CENTER);
     // Draw grid of potential colors to choose from for player 1
     for(int y = 1; y <= 2; ++y)
       for(int x = 1; x <= 4; ++x){
          // Fill outline of box based on if it is selected
          if(player1_color == customize_color[count])
            stroke(#46add4);
          // Fill outline of box based on if it is hovered over
           else if(mouseX > (width/5)*x-75/2 && mouseX < (width/5)*x+75/2 && mouseY > 100*y+100-75/2 && mouseY < 100*y+100+75/2)
            stroke(255);
           else
             stroke(0);
         
          fill(customize_color[count++]);
          rect((width/5)*x, 100*y+100, 75, 75);
       }
       
     // Display colors for player 2:
     textSize(28);
     fill(255);
     text("Player 2:", width/2, 375);
    
     // Draw grid of potential colors to choose from for player 2
     count = 0;
     for(int y = 1; y <= 2; ++y)
       for(int x = 1; x <= 4; ++x){
          // Fill outline of box based on if it is selected
          if(player2_color == customize_color[count])
            stroke(#46add4);
          // Fill outline of box based on if it is hovered over
           else if(mouseX > (width/5)*x-75/2 && mouseX < (width/5)*x+75/2 && mouseY > 100*y+350-75/2 && mouseY < 100*y+350+75/2)
            stroke(255);
           else
             stroke(0);
         
          fill(customize_color[count++]);
          rect((width/5)*x, 100*y+350, 75, 75);
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
     // Change button highlight if mouse is hovering over 
     if(dist(mouseX, mouseY, 75, 75) < 75/2)
        stroke(70, 173, 212);
     else
        stroke(0); 
        
     strokeWeight(8);
     ellipseMode(CENTER);
     ellipse(75, 75, 75, 75);   
     
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
     else if(mouseX > width/4-50-200/2 && mouseX < width/4-50+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2)
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
     else if(mouseX > 2*width/4-200/2 && mouseX < 2*width/4+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2)
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
     else if(mouseX > 3*width/4+50-200/2 && mouseX < 3*width/4+50+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2)
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
     else if(mouseX > width/4-50-200/2 && mouseX < width/4-50+200/2 && mouseY > 425-125/2 && mouseY < 425+125/2)
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
     else if(mouseX > 2*width/4-200/2 && mouseX < 2*width/4+200/2 && mouseY > 425-125/2 && mouseY < 425+125/2)
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
     else if(mouseX > 3*width/4+50-200/2 && mouseX < 3*width/4+50+200/2 && mouseY > 425-125/2 && mouseY < 425+125/2)
       stroke(255);
     else
       stroke(0);
     
     image(map6, 3*width/4+50-200/2, 425-125/2, 200, 125);
     rect(3*width/4+50, 425, 200, 125);  
     
     noTint();
     
     // Draw start button
     // Change outline based on mouse hover
     if(mouseX > width/2-175/2 && mouseX < width/2+175/2 && mouseY > height-40-50/2 && mouseY < height-40+50/2)
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
   
      
   // Method for controlling what happens when a mouse is clicked on the menu page
   void mousepressed_menu(){
     // Play Game button is pressed
      if(mouseX < width/2+245/2 && mouseX > width/2-245/2 && mouseY > 300-70/2 && mouseY < 300+70/2)
        selection = "game";
          
      // Instructions button is pressed
      else if(mouseX < width/4+200/2 && mouseX > width/4-200/2 && mouseY > 400-50/2 && mouseY < 400+50/2)
        selection = "instructions";
        
      // Settings button is pressed    
      else if(mouseX < width/4+200/2 && mouseX > width/4-200/2 && mouseY > 475-50/2 && mouseY < 475+50/2) {
        selection = "settings";
        first_load = true;
      }
        
      // Customize button is pressed
      else if(mouseX < 3*width/4+200/2 && mouseX > 3*width/4-200/2 && mouseY > 400-50/2 && mouseY < 400+50/2)
        selection = "maps";
  
      // Scores button is pressed    
      else if(mouseX < 3*width/4+200/2 && mouseX > 3*width/4-200/2 && mouseY > 475-50/2 && mouseY < 475+50/2){
        selection = "customize";
        first_load = true;
      }
        
      // Exit button is pressed    
      else if(mouseX < width/2+200/2 && mouseX > width/2-200/2 && mouseY > 550-50/2 && mouseY < 550+50/2)
        selection = "exit";
        
      // Music toggle button is pressed    
      else if(dist(mouseX, mouseY, 40, height-40) < 50)
        music = !music;
        
      // Sound effects toggle button is pressed 
      else if(dist(mouseX, mouseY, 100, height-40) < 50)
        sound_effect = !sound_effect;
        
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
      if(dist(mouseX, mouseY, width/4+150, 175) < 15/2){
        num_players = 2;
      }
      else if(dist(mouseX, mouseY, width/4+300, 175) < 15/2){
        num_players = 3;
      }
      else if(dist(mouseX, mouseY, width/4+450, 175) < 15/2){
        num_players = 4;
      }
      
      // Mouse pressed to change lives
      if(dist(mouseX, mouseY, width/4+150, 275) < 15/2)
        lives = 1;
      if(dist(mouseX, mouseY, width/4+300, 275) < 15/2)
        lives = 3;
      if(dist(mouseX, mouseY, width/4+450, 275) < 15/2)
        lives = 5;
        
      // Mouse pressed to change number of user players
      // 2 Players:
      if(mouseX > width/4+400-150/2 && mouseX < width/4+400+150/2 && mouseY > 350-25 && mouseY < 350+25)
        users = true;
      // 1 Player:
      if(mouseX > width/4+200-150/2 && mouseX < width/4+200+150/2 && mouseY > 350-25 && mouseY < 350+25)
        users = false;

      // Mouse pressed to change song playing 
      if(dist(mouseX, mouseY, width/4+150, 475) < 15/2)
        song_selection = 1;
      else if(dist(mouseX, mouseY, width/4+300, 475) < 15/2)
        song_selection = 2;
      else if(dist(mouseX, mouseY, width/4+450, 475) < 15/2)
        song_selection = 3;
      
     // Mouse pressed to change difficulty
     // Mouse pressed on hard difficulty 
     if(mouseX > width/4+350 && mouseX < width/4+450 && mouseY > 525 && mouseY < 575)
       difficulty = true;
     // Mouse pressed on easy difficulty
     else if(mouseX > width/4+150 && mouseX < width/4+250 && mouseY > 525 && mouseY < 575)
       difficulty = false;
   }
   
   
   // Method for controlling what happens when a mouse is clicked on the maps page. The method returns a number corresponding to the level selected from this page. 
   // [1-6] corresponding to levels 1-6. 0 indicates the play button has been pressed. Any negative number indicates that all other events.
   void mousepressed_maps(){
      // Back button is pressed
      if(dist(mouseX, mouseY, 75, 75) < 75/2)
        selection = "menu";
      
      // Map 1 is selected
      else if(mouseX > width/4-50-200/2 && mouseX < width/4-50+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2)
        map = 1;
        
      // Map 2 is selected
      else if(mouseX > 2*width/4-200/2 && mouseX < 2*width/4+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2)
        map = 2;
      
      // Map 3 is selected
      else if(mouseX > 3*width/4+50-200/2 && mouseX < 3*width/4+50+200/2 && mouseY > 225-125/2 && mouseY < 225+125/2) 
        map = 3;
             
      // Map 4 is selected
      else if(mouseX > width/4-50-200/2 && mouseX < width/4-50+200/2 && mouseY > 225-425/2 && mouseY < 225+425/2) 
        map = 4;
      
      // Map 5 is selected
      else if(mouseX > 2*width/4-200/2 && mouseX < 2*width/4+200/2 && mouseY > 225-425/2 && mouseY < 225+425/2) 
        map = 5;
      
      // Map 6 is selected
      else if(mouseX > 3*width/4-200/2 && mouseX < 3*width/4+200/2 && mouseY > 225-425/2 && mouseY < 225+425/2)
        map = 6;
      
      // Start button is pressed
      else if(mouseX > width/2-175/2 && mouseX < width/2+175/2 && mouseY > height-40-50/2 && mouseY < height-40+50/2)
        selection = "game";
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
      
      // Player 1 Color Selection:
      // Loop through each color option and see if any have been selected
      for(int y = 1; y <= 2; ++y)
        for(int x = 1; x <= 4; ++x){
          // Check if mouse click is within bounds of a particular box
           if(mouseX > (width/5)*x-75/2 && mouseX < (width/5)*x+75/2 && mouseY > 100*y+100-75/2 && mouseY < 100*y+100+75/2)
            player1_color = customize_color[index++];   // Set color selection to index if true
          else 
            ++index;
      }   
      
      // Player 2 Color Selection:
      // Loop through each color option and see if any have been selected
      index = 0;
      for(int y = 1; y <= 2; ++y)
        for(int x = 1; x <= 4; ++x){
          // Check if mouse click is within bounds of a particular box
           if(mouseX > (width/5)*x-75/2 && mouseX < (width/5)*x+75/2 && mouseY > 100*y+350-75/2 && mouseY < 100*y+350+75/2)
            player2_color = customize_color[index++];   // Set color selection to index if true
          else 
            ++index;
      } 
   }
   
   // Method for controlling what happens when mouse clicks exit button
   void mousepressed_exit(){ exit(); }
}
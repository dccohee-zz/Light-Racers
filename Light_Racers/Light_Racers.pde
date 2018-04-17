import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Menu menu;
Maps map;
Game game;
Racer[] car = new Racer[4];

void setup(){
 size(800, 600); 
 menu = new Menu();
 map = new Maps();
 game = new Game();
 car[0] = new Racer(color(0, 0, 255), 30, 30, 15, 3, 3, 0);
 car[1] = new Racer(color(#FF0101), map.get_w()-30, map.get_h()-30, 15, 3, -3, 0);   // Begin in lower right corner
 car[2] = new Racer(color(#CC5500), 30, map.get_h()-30, 15, 3, 3, 0);   // Begin in lower left corner
 car[3] = new Racer(color(#CCCC00), map.get_w()-30, 30, 15, 3, -3, 0);   // Begin in upper right corner
}

void draw(){
  if(menu.get_selection().equals("menu")){
    menu.display_main_menu();
    menu.mouse_hover_menu();
  }
  
  else if(menu.get_selection().equals("instructions"))
    menu.display_instructions();

  else if(menu.get_selection().equals("settings"))
    menu.display_settings();
    
  else if(menu.get_selection().equals("customize")){
    menu.display_customize();
    menu.mouse_hover_customize();
  }
    
  else if(menu.get_selection().equals("playmode"))
    menu.display_playmode();
    
  else if(menu.get_selection().equals("maps")){
    menu.display_maps();
    menu.mouse_hover_maps();
  }
    
  else if(menu.get_selection().equals("game")){ 
    if(game.get_play()){    
      map.display_map();   // Display current map
      
      int death_count = 0;
      
      // Iterate through every player and perform action
      for(int i = 0; i < 1; ++i){
        if(car[i].get_lives() == 0)
          continue;
        
        car[i].display();   // Draw vehicle
        car[i].update(game.get_light_trail());   // Update vehicle
        
        car[i].check_collision(game.get_light_trail());   // Check if car has run into obstical or wall
        
        death_count = (car[i].get_lives() == 0) ? ++death_count : death_count;
      }
      
      if(death_count == game.get_num_players()-1){
        for(int i = 0; i < 1; ++i)
          car[i].reset();
          game.reset();
          map.stop_song();
          menu.set_selection("menu");
          menu.set_first_load(true);
      }
      
    }
  }
    
  else if(menu.get_selection().equals("exit"))
    this.exit();
   
}

void keyPressed(){
  car[0].press_key();  // Change user's car based on key presses
}


void mousePressed() {
  // If on menu screen...
  if(menu.get_selection().equals("menu"))
    menu.mousepressed_menu();
    
  // If on instruction screen...
  else if(menu.get_selection().equals("instructions"))
    menu.mousepressed_instructions();

  // If on settings screen...
  else if(menu.get_selection().equals("settings")){
    menu.mousepressed_settings();
    
    // Change game settings based on what was pressed in settings screen
    map.set_song(menu.get_song_selection());   // Update song selection
    game.set_num_players(menu.get_num_players());   // Update number of players
    game.set_difficulty(menu.get_difficulty(), car);   // Update difficulty head
  }
    
  // If on customize screen...
  else if(menu.get_selection().equals("customize")){
    menu.mousepressed_customize();
    
    car[0].set_color(menu.get_color());   // Set color of user car based on what user mouse clicked
  }
    
  // If on scores screen...
  else if(menu.get_selection().equals("playmode")){
    menu.mousepressed_playmode();
    game.set_play(true);
  }
    
  // If on maps screen...
  else if(menu.get_selection().equals("maps")) {
    int level = menu.mousepressed_maps();   // Method returns the map selected
    
    // Set level to map user selected (map 1 through map 6)
    if(level >= 1 && level <= 6)
      map.set_level(level);
      
    // If 0 is returned, user pressed play button
    else if(level == 0) {   
      // Switch statement to display map based on selection
       switch(map.get_level()){       
         // Display level 1
         case 1: { 
           break; 
         }
         // Display level 2 and set obsticals inside light trails array
         case 2: { 
           map.set_level2_obsticals(game.get_light_trail(), car[0].get_width()); 
           break;
         }
         // Display level 3 and set obsticals inside light trails array
         case 3: { 
           map.set_level3_obsticals(game.get_light_trail(), car[0].get_width());
           break; 
         }
         // Display level 4 and set obsticals inside light trails array
         case 4: {  
           map.set_level4_obsticals(game.get_light_trail(), car[0].get_width());
           break; 
         }
         // Display level 5 and set obsticals inside light trails array
         case 5: { 
           map.set_level5_obsticals(game.get_light_trail(), car[0].get_width());
           break; 
         }
         // Display level 6 and set obsticals inside light trails array
         case 6: { 
           map.set_level6_obsticals(game.get_light_trail(), car[0].get_width());
           break; 
         }
       }
         
       // Initalize game after loading level
       menu.curr_song_stop();   
       menu.set_selection("game");  
       game.set_play(true);
    }
  }
  
  // If playing game...
  else if(menu.get_selection().equals("game")){
    map.mousepressed_menubar(); 
    
    /*
    // If returned true, player has exited out of the game
    if(exit)
      game.set_play(false);   // End current game sequence
      map.stop_song();   // End current song
      menu.set_selection("menu");   // Return to menu screen
      menu.set_first_load(true);
    }
    */
  }
     
  // Else, if exit button is pressed...
  else if(menu.get_selection().equals("exit"))
    menu.mousepressed_exit();
}
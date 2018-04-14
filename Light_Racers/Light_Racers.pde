import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Menu menu;
Maps map;
Game game;
Racer user, comp1, comp2, comp3;

void setup(){
 size(800, 600); 
 menu = new Menu();
 map = new Maps();
 game = new Game();
 user = new Racer(color(0, 0, 255), 10, 10, 15, 3, 0, 3);
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
    
  else if(menu.get_selection().equals("customize"))
    menu.display_customize();
    
  else if(menu.get_selection().equals("scores"))
    menu.display_scores();
    
  else if(menu.get_selection().equals("maps")){
    menu.display_maps();
    menu.mouse_hover_maps();
  }
    
  else if(menu.get_selection().equals("game")){ 
    if(game.get_play()){
      // Draw car:
      user.display();  
      
      // Update position:
      user.update();   
      
      // Check if destroyed:
      boolean wall_result = map.check_wall(user.get_x(), user.get_y(), user.get_width()/2);   // Check if car is within bounds of walls
      boolean trail_result = game.get_light_trail(user.get_x(), user.get_y());   // Check if car has run into pre-existing light trail
      
      game.set_light_trail(user.get_x(), user.get_y());   // Update light trail array with position of car
      
      // If car has hit wall or light-trail, reset the game 
      if(wall_result || trail_result) {
        user.reset_car();
        game.reset();
        map.stop_song();   // End current song
        menu.set_selection("menu");   // Return to menu screen
        menu.set_first_load(true);
      }
    }
  }
    
  else if(menu.get_selection().equals("exit"))
    this.exit();
   
}

void keyPressed(){
  user.press_key(); 
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
    game.set_difficulty(menu.get_difficulty());   // Update difficulty head
  }
    
  // If on customize screen...
  else if(menu.get_selection().equals("customize"))
    menu.mousepressed_customize();
    
  // If on scores screen...
  else if(menu.get_selection().equals("scores")){
    menu.mousepressed_scores();
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
           map.display_level1();
           break; 
         }
         // Display level 2 and set obsticals inside light trails array
         case 2: { 
           map.display_level2();
           map.set_level2_obsticals(game.get_light_trail(), user.get_width()); 
           break;
         }
         // Display level 3 and set obsticals inside light trails array
         case 3: { 
           map.display_level3(); 
           map.set_level3_obsticals(game.get_light_trail(), user.get_width());
           break; 
         }
         // Display level 4 and set obsticals inside light trails array
         case 4: { 
           map.display_level4(); 
           map.set_level4_obsticals(game.get_light_trail(), user.get_width());
           break; 
         }
         // Display level 5 and set obsticals inside light trails array
         case 5: { 
           map.display_level5(); 
           map.set_level5_obsticals(game.get_light_trail(), user.get_width());
           break; 
         }
         // Display level 6 and set obsticals inside light trails array
         case 6: { 
           map.display_level6(); 
           map.set_level6_obsticals(game.get_light_trail(), user.get_width());
           break; 
         }
         // Default case: display level 1
         default: { 
           map.display_level1();
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
    boolean exit = map.mousepressed_menubar(); 
    
    // If returned true, player has exited out of the game
    if(exit) {
      game.set_play(false);   // End current game sequence
      map.stop_song();   // End current song
      menu.set_selection("menu");   // Return to menu screen
      menu.set_first_load(true);
    }
  }
     
  // Else, if exit button is pressed...
  else if(menu.get_selection().equals("exit"))
    menu.mousepressed_exit();
}
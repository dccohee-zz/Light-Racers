import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Menu menu;
Maps map;
Game game;

void setup(){
 size(800, 600); 
 menu = new Menu();
 map = new Maps();
 game = new Game();
 
}

void draw(){
  if(menu.get_selection().equals("menu"))
    menu.display_main_menu();
  
  else if(menu.get_selection().equals("instructions"))
    menu.display_instructions();

  else if(menu.get_selection().equals("settings"))
    menu.display_settings();
    
  else if(menu.get_selection().equals("customize"))
    menu.display_customize();
    
  else if(menu.get_selection().equals("scores"))
    menu.display_scores();
    
  else if(menu.get_selection().equals("maps"))
    menu.display_maps();
    
  else if(menu.get_selection().equals("game")){
    if(game.get_play()){
      map.draw_map(game.get_level());
    }
  }
    
  else if(menu.get_selection().equals("exit"))
    this.exit();
   
}


void mousePressed() {
  // If on menu screen...
  if(menu.get_selection().equals("menu"))
    menu.mousepressed_menu();
    
  // If on instruction screen...
  else if(menu.get_selection().equals("instructions"))
    menu.mousepressed_instructions();

  // If on settings screen...
  else if(menu.get_selection().equals("settings"))
    menu.mousepressed_settings();
    
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
    
    // Set level if valid map is selected
    if(level > 0 && level <= 6)
      game.set_level(level);
    // If zero is returned, begin the game
    else if(level == 0) {
      menu.curr_song_stop();
      menu.set_selection("game");  
      game.set_play(true);
      game.get_song();
      map.draw_map(level);   // Draw map based on which one was selected
    }
  }
  
  // If playing game...
  else if(menu.get_selection().equals("game")){
    boolean exit = map.mousepressed_menubar(); 
    
    // If returned true, player has exited out of the game
    if(exit) {
      game.set_play(false);   // End current game sequence
      game.stop_song();   // End current song
      menu.set_selection("menu");   // Return to menu screen
      menu.set_first_load(true);
    }
  }
     
  // Else, if exit button is pressed...
  else if(menu.get_selection().equals("exit"))
    menu.mousepressed_exit();
}
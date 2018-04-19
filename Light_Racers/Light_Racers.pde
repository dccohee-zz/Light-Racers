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

IntList rank; // Array to list the ranking from winner to loser 

void setup(){
 size(800, 600); 
 menu = new Menu();
 map = new Maps();
 game = new Game();
 car[0] = new Player1(color(0, 0, 255), 30, 30, 10, 1, 0, 1);
 car[1] = new AI(color(#FF0101), map.get_w()-29, map.get_h()-29, 10, 1, 0, -1);   // Begin in lower right corner
 car[2] = new AI(color(#CC5500), 30, map.get_h()-29, 10, 1, 1, 0);   // Begin in lower left corner
 car[3] = new AI(color(#CCCC00), map.get_w()-29, 30, 10, 1, -1, 0);   // Begin in upper right corner
 
 rank = new IntList();
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

  else if(menu.get_selection().equals("maps"))
    menu.display_maps();
    
  else if(menu.get_selection().equals("game")){   
    int death_count = 0;   // Variable keeping track of number of cars destroyed
    
    // If in game mode and round is ongoing
    if(game.get_play()){         
      map.display_menubar(car, game.get_num_players());   // Display menu bar at bottom of screen
      map.display_map();   // Display current map
      
      // Iterate through every player and perform action
      for(int i = 0; i < game.get_num_players(); ++i){
        // If car has already been destroyed, ignore displaying and updating
        if(car[i].get_lives() == 0){
          ++death_count;  // Increase the number of cars destroyed
          
          // Append death to the ranking list if it hasn't already
          if(!rank.hasValue(i+1))
            rank.append(i+1);
          
          continue;
        }
        
        car[i].display();   // Draw vehicle
        car[i].update(game.get_light_trail());   // Update vehicle
        car[i].check_collision(game.get_light_trail());   // Check if car has run into obstical or wall
      }
      
      // Check if all but 1 player has been destroyed
      if(death_count == game.get_num_players()-1){
        game.set_play(false);    // End game round
      }      
    }
    // Else, if in game mode and round is over
    else {
      // Iterate through all players and find the winner
      for(int i = 0; i < game.get_num_players(); ++i)
        if(car[i].get_lives() != 0 && !rank.hasValue(i+1)) 
          rank.append(i+1); 
        
        
      map.display_endgame(rank);
    }
  }
    
  else if(menu.get_selection().equals("exit"))
    this.exit();
   
}

void keyPressed(){
  car[0].press_key();  // Change player 1 direction based on key presses
  car[1].press_key();   // Change player 2 direction based on key pressed
}


void mousePressed() {
  // If on menu screen...
  if(menu.get_selection().equals("menu")) {
    menu.mousepressed_menu(); 
    
    // Check if game has been selected
    if(menu.get_selection().equals("game")){
       menu.curr_song_stop();   
       menu.set_selection("game");  
       game.set_play(true);
    }
    
  }
    
  // If on instruction screen...
  else if(menu.get_selection().equals("instructions"))
    menu.mousepressed_instructions();

  // If on settings screen...
  else if(menu.get_selection().equals("settings")){
    menu.mousepressed_settings();
    
    // Update the number of users (1-player/2-players)
    if(menu.get_users())
      car[1] = new Player2(color(#FF0101), map.get_w()-29, map.get_h()-29, 10, 1, 0, -1);   // Begin in lower right corner
    else
      car[1] = new AI(color(#FF0101), map.get_w()-29, map.get_h()-29, 10, 1, 0, -1);   // Begin in lower right corner
    
    // Change game settings based on what was pressed in settings screen
    map.set_song(menu.get_song_selection());   // Update song selection
    game.set_num_players(menu.get_num_players());   // Update number of players
    game.set_difficulty(menu.get_difficulty(), car);   // Update difficulty head
    
    // Update number of lives
    for(int i = 0; i < car.length; ++i)
      car[i].set_lives(menu.get_lives());

      
  }
    
  // If on customize screen...
  else if(menu.get_selection().equals("customize")){
    menu.mousepressed_customize();
    
    car[0].set_color(menu.get_color());   // Set color of user car based on what user mouse clicked
  }
    
  // If on maps screen...
  else if(menu.get_selection().equals("maps")) {
    menu.mousepressed_maps();   // Method returns the map selected
    
    // If play game has been selected on map screen...
    if(menu.get_selection().equals("game")){
      map.set_level(menu.get_map());   // Set level that needs to be displayed
      map.set_obsticals(game.get_light_trail(), car[0].get_width());   // Load obstical locations in to light trail array
      
               
      // Initalize game after loading level
      menu.curr_song_stop();   
      menu.set_selection("game");  
      game.set_play(true);
   }

 }
  
  // If playing game...
  else if(menu.get_selection().equals("game")){
    int result = -1; 
    
    // If round if ongoing
    if(game.get_play())
      result = map.mousepressed_menubar();   // Check if button is pressed on menu bar
    // Else, if round if over
    else
      result = map.mousepressed_endgame();   // Check if button is pressed on end game screen
      
    // 0 indicates restart round
    if(result == 0) {      
      // Reset properties of car for when game begins again
      for(int i = 0; i < game.get_num_players(); ++i)
        car[i].reset();
          
      game.reset();  
      rank.clear();   // Clear round rankings
    }
      
    // 1 indicates exit game
    else if(result == 1){
      map.stop_song();
      menu.set_selection("menu");
      menu.set_first_load(true);
          
      // Reset properties of car for when game begins again
      for(int i = 0; i < game.get_num_players(); ++i)
         car[i].reset();
          
      game.reset();
      rank.clear();   // Clear round rankings
    }
}
     
  // Else, if exit button is pressed...
  else if(menu.get_selection().equals("exit"))
    menu.mousepressed_exit();
}
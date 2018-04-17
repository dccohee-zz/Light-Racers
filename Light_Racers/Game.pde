class Game {
  // DATA FIELDS
  public boolean[][] light_trail;
  private int score;
  private int num_players;
  private boolean difficulty;
  private int level;
  private boolean play;
    
  // CONSTRUCTORS
  Game(){   
   // Dynamically allocate 2D array the size of the playing arena
   // Set all values to false (indicating that none of the spaces have been occupied)
   light_trail = new boolean[width][height-100];
   for(int x = 0; x < light_trail.length; ++x)  
     for(int y = 0; y < light_trail[x].length; ++y)
       light_trail[x][y] = false;
  
   score = 0;
   num_players = 2;
   difficulty = false;   // true = hard difficutly; false = easy difficulty
   level = 1;   
   play = false;   // Variable for controlling when the game is in play and when it is finished
  }
  
  // METHODS
  // Accessors and Mutators for data members
  // Getter/setter for level
  int get_level() { return this.level; }
  void set_level(int level) { this.level = level; }
  
  // Getter/setter for score
  int get_score() { return this.score; } 
  void set_score(int score) { this.score = score; }
  
  // Getter/setter for number of player
  int get_num_players() { return this.num_players; }
  void set_num_players(int num_players) { 
    // Check that the number of players passed in is a valid number for the game
    // If the number is less than 2, set it to the minimum of players for the game (2)
    if(num_players < 2)
      this.num_players = 2;
    // If the number of players if greater than 4, set it to the maximum numbmer of players for the game (4)
    else if(num_players > 4)
      this.num_players = 4;
    // Else, set it to the number of players passed in 
    else 
      this.num_players = num_players; 
    }
    
    // Getter/setter for difficulty
    boolean get_difficulty() { return this.difficulty; }
    
    void set_difficulty(boolean difficulty, Racer[] cars) { 
      this.difficulty = difficulty;   // Set difficulty
      
      // Iterate through every car in array
      for(int i = 0; i < cars.length; ++i){
        // If difficulty increased, increase speed
        if(difficulty)
          car[i].set_speed(3);
        // Else, decrease speed
        else
          car[i].set_speed(1);
        
        car[i].reset();   // Reset cars with new speeds
      }
    }
    
    // Getter/setter for play
    boolean get_play() { return this.play; }
    void set_play(boolean play) { this.play = play; } 
    
    // Getter/setter for light trail
    boolean get_light_trail(int x, int y) { return this.light_trail[x][y]; }
    boolean[][] get_light_trail() { return this.light_trail; }
    void set_light_trail(int x, int y) {
      light_trail[x][y] = true;
    }
    
    void reset(){
     for(int x = 0; x < light_trail.length; ++x)  
       for(int y = 0; y < light_trail[x].length; ++y)
         light_trail[x][y] = false;
         
      play = false;
    }
 }
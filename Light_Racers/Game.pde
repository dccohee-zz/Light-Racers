class Game {
  // DATA FIELDS
  private Minim minim;
  private AudioPlayer curr_song, song1, song2, song3;
  
  private boolean[][] light_trail;
  private int score;
  private int num_players;
  private boolean difficulty;
  private boolean[] items;
  private int level;
  private boolean play;
    
  // CONSTRUCTORS
  Game(){
   // Load all songs to be used in game
   minim = new Minim(Light_Racers.this);
   song1 = minim.loadFile("Derezzed.mp3");
   song2 = minim.loadFile("Tron Legacy (End Titles).mp3");
   song3 = minim.loadFile("The Game Has Changed.mp3");
   curr_song = song1;
   
   // Dynamically allocate 2D array the size of the playing arena
   // Set all values to false (indicating that none of the spaces have been occupied)
   light_trail = new boolean[width][height-100];
   for(int i = 0; i < light_trail.length; ++i)
     for(int j = 0; j < light_trail[i].length; ++j)
       light_trail[i][j] = false;
  
   score = 0;
   num_players = 2;
   difficulty = false;   // true = hard difficutly; false = easy difficulty
  
   // Dynmically create array to indicate the items being used each game
   items = new boolean[5];
   // Set all items to be used in play
   for(int i = 0; i < items.length; ++i)
     items[i] = true;
   
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
    void set_difficulty(boolean difficulty) { this.difficulty = difficulty; }
    
    // Getter/setter for play
    boolean get_play() { return this.play; }
    void set_play(boolean play) { this.play = play; } 
    
    // Getter/setter for song
    void get_song() { curr_song.play(); }    // (Getter only plays song instead of returning the song)
    
    void set_song(int choice) 
    { 
      // Validate that song choice passed in is within expected parameters
      if(choice < 1 || choice > 3)
        return;
       
       // Switch statement to change song based on choice
       switch(choice) {
        case 1: curr_song = song1;
        case 2: curr_song = song2;
        case 3: curr_song = song3;
       }
    }
    
    void stop_song() {
      curr_song.pause();
      curr_song.rewind();
    }

}
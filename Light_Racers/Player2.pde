/*
Authors: Dalton Cale Cohee and Douglas Easom 
Date: 18 April 2018
Program: Light Racer: Player 2
Program Description: This class implements the abstacted racer class to create an racer for a second user player. The class is very similar to the the Player 1 class, but the keys to control Player 2's racer are different  
*/

class Player2 implements Racer {
  // DATA MEMBERS:
  private color c;   // Color of car
  private int x, y;   // Position of car on grid
  private int start_x, start_y;   // Initial spawn position of car 
  private int car_width;    // Width of car
  private float vx, vy;   // Speed of car
  private float speed; 
  private IntList light_trail_x, light_trail_y;    // List to track each car's personal light trail
  private int lives;   // Variable to track the number of lives for a car
  private int start_lives;   // Variable to track the number of lives a car begins with so it knows when restarting
  
  // Load audio player for sound effects
  private Minim minim;
  private AudioPlayer drive, crash;
  
  // CONSTRUCTORS:
  // Default Constructor
  Player2(){
   x = 30;
   y = 25;
   car_width = 15;
   c = color(#002BFA);
   speed = 3;
   vx = 0;
   vy = speed;
   light_trail_x = new IntList();
   light_trail_y = new IntList(); 
   lives = 1;
   
   // Load sound effects for driving and crashing
   minim = new Minim(Light_Racers.this);
   drive = minim.loadFile("Driving.mp3");
   crash = minim.loadFile("Crash.mp3");
  }
  
  // Overloaded Constructor
  Player2(color c, int start_x, int start_y, int car_width, float speed, float vx, float vy){
    this.c = c;
    this.start_x = start_x;
    this.start_y = start_y;
    x = start_x;
    y = start_y;
    this.car_width = car_width;
    this.speed = speed;
    this.vx = vx;
    this.vy = vy;
    light_trail_x = new IntList();
    light_trail_y = new IntList();    
    start_lives = 1;
    lives = start_lives; 
    
   // Load sound effects for driving and crashing
   minim = new Minim(Light_Racers.this);
   drive = minim.loadFile("Driving.mp3");
   crash = minim.loadFile("Crash.mp3");
  }
  
  // METHODS:
  // Accessor and Mutator methods for data fields
  // Accessor for x-location
  int get_x(){ return this.x; }
  
  // Accessor for y-location
  int get_y(){  return this.y; }
  
  // Accessors for car width
  int get_width() { return this.car_width; }
  
  // Getter/Setter for color
  color get_color() { return this.c; }
  void set_color(color c) { this.c = c; }
  
  // Getter/setter for speed
  float get_speed() { return this.speed; }
  void set_speed(float speed) { this.speed = speed; }
  
  // Getter/setter for lives
  int get_lives() { return this.lives; }
  void set_lives(int lives) { 
    this.lives = lives; 
    this.start_lives = lives;
  }
  
  // Method for looping driving sound effect for when racer starts driving
  void start_sound() { drive.setVolume(0.5); }
  
  // Method for stoping sound effect when car is destroyed or round is over
  void stop_sound() { drive.pause(); drive.rewind(); }
  
  // Method for playing crash sound effect when car is destroyed
  void crash_sound() { crash.play(); crash.rewind(); }
  
  // Draw car
  void display(){
    // Display current location of car
    rectMode(CENTER);
    fill(c);
    noStroke();
    rect(x, y, car_width, car_width);
    
    // Display previous trail of car
    // Iterate through all indices of car trail
    for(int i = 0; i < light_trail_x.size(); ++i){
      // Retrieve (x,y) coordinates
      int x = light_trail_x.get(i);
      int y = light_trail_y.get(i);
      rect(x, y, car_width, car_width);   // Draw path at coordinates
    }
  }
   
  // Update car's position based on speed
  void update(boolean[][] light_trail){
    // Update car location based on velocity  
    light_trail[x][y] = true;
    this.light_trail_x.append(x); 
    this.light_trail_y.append(y);
    
    x += vx; 
    y += vy;
  }
  
  // Method for respawning a car. It inputs the master light-trail data structure and sets the cars previous light trail to be untouched
  void respawn(boolean[][] light_trail){
    // Do not respawn if out of lives
    if(lives == 0)
      return;
    
    // Iterate through previous light trail trace
    for(int i = 0; i < light_trail_x.size(); ++i){
      int x = light_trail_x.get(i);   // Get x-location
      int y = light_trail_y.get(i);   // Get y-location
      light_trail[x][y] = false;    // Unmark location
    }
    
    // Clear previous light trails
    light_trail_x.clear();   
    light_trail_y.clear();
      
    // Reset location
    x = start_x;
    y = start_y;
    
    // Reset speed based on position
    if(start_x < 100){
      vx = speed;   // Move right
      vy = 0;  
    }
    // Start in right side
    else if(start_x > 100){
     vx = -speed;   // Move left 
     vy = 0;    
    }      
  }
  
  // Method for checking if a racer has encountered an obstacle, a light trail, or a wall
  boolean check_collision(boolean[][] light_trail){    
    boolean collision = false;   // Variable to track if a car has been destroyed
    
    // The width of the racer needs to be taken into account so that not just the center of the car is taken into consideration
    int x_offset = 0;
    int y_offset = 0;
    
    // Calculate the offset ahead of the racer based on its traveling direction
    if(vx > 0 && vy == 0)  
      x_offset = car_width;
    else if (vx < 0 && vy == 0)
      x_offset = -car_width;
    else if(vx == 0 && vy > 0)
      y_offset = car_width;
    else if(vx == 0 && vy < 0)  
      y_offset = -car_width;
    
    // Check if car has extended beyond boundaries of wall
    if(x+x_offset < 0 || y+y_offset < 0 || x+x_offset >= light_trail.length || y+y_offset >= light_trail[0].length)
      collision = true;
    
    
    // Check if car has run into obstical
    else if(light_trail[x+x_offset][y+y_offset] == true)
      collision = true;

    // If a collision occurred
    if(collision){
      --lives;   // Diminish number of lives 
      respawn(light_trail);   // Respawn car
    }
    
    return collision;
}
 
  
  // Change car's direction based on key stroke
  void press_key(){
    // Up arrow key is pressed:
    if(key == 'w'){
      // If car is already moving up, cannot go backwards or forwards
      if(vy < 0 || vy > 0)
        return;
      // Else, change direction to up
      else{
       vy = -speed;
       vx = 0;
      }
    }
    
    // Down arrow key is pressed
    else if(key == 's'){
      // If car is already moving down, cannot go backwards or forwards
      if(vy < 0 || vy > 0)
        return;
      // Else, change direcion to down
      else{
         vy = speed;
         vx = 0;
       }
    }
    
    // Left arrow key is pressed
    else if(key == 'a'){
      // If car is already moving left, cannot go backwards or forwards
      if(vx < 0 || vx > 0)
        return;
      // Else, change direction to left
      else{
        vx = -speed;
        vy = 0;
      }
    }
    
    // Right arrow is pressed
    else if(key == 'd'){
      // If car is already moving right, cannot go backwards or forwards
      if(vx < 0 || vx > 0)
        return;
      // Else, change direction to right
      else{
        vx = speed;
        vy = 0;
      }
    }
  }
      
    // Method to reset class fields
    void reset(){
      light_trail_x.clear();
      light_trail_y.clear();
      lives = start_lives;
      x = start_x; 
      y = start_y;
      
      drive.pause(); drive.rewind();  // Stop driving effects
      
      // Set starting speeds based on position
      // Start in left side
      if(start_x < 100){
        vx = speed;   // Move right
        vy = 0;  
      }
      // Start in right side
      else if(start_x > 100){
       vx = -speed;   // Move left 
       vy = 0;    
      }        
    }
}
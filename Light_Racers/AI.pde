/*
Authors: Dalton Cale Cohee and Douglas Easom 
Date: 15 April 2018
Program: Light Racer: AI
Program Description: This class implements the abstacted racer class to create an AI racer. The class includes drawing and updating the racer, and dynamically checking for obstacles to avoid.  
*/

class AI implements Racer {
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
  
  // Load sound effects for racer
  private Minim minim;
  private AudioPlayer drive, crash;

  // CONSTRUCTORS:
  // Default Constructor
  AI(){
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
  AI(color c, int start_x, int start_y, int car_width, float speed, float vx, float vy){
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
  void start_sound() { drive.loop(); }
  
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
  
  // Function for randomly changing AI direction to give it a more human-feeling.
  void update(boolean[][] light_trail){
     light_trail[x][y] = true;
     light_trail_x.append(x);
     light_trail_y.append(y);
     
     x += vx;
     y += vy;
  }
  
    
  // Method for checking if a racer has encountered an obstacle and should be destroyed/respawn
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
      
    // Else, check if obstacle is in AI's path
    else{
      change_direction(light_trail);   // Randomly change direction to give more human-feel
      check_obstacles(light_trail);   // Check if obstacle is in path     
    }

    // If a collision occurred
    if(collision){
      --lives;   // Diminish number of lives 
      respawn(light_trail);   // Respawn car
    }
    
    return collision;
  }
          
  
  // Method for randomly changing the AI's direction in attempts to give the racer more of a human-esque feel
  void change_direction(boolean[][] light_trail){    
     int change = (int)random(100);   // Generate a random number to determine if to change direction
     
     // If a certain number is generated, randomly change direction
     if(change == 1){
       // If moving in the x-direction
       if(vx != 0 && vy == 0) {
         int direction = (int)random(2);
         // Change y-direction based on randomly generated number
         if(direction == 0)
           change_up(light_trail);   // 0 indicates change up
         else
           change_down(light_trail);   // 1 indates change down
         
       }
       
       // If moving in the y-direction
       else if(vx == 0 && vy != 0) {
         // Randomly shift to moving in the x-direction
         int direction = (int)random(2);
         
         // Update x-direction based on random generated number
         // 0 indicates to turn left
         if(direction == 0)
           change_left(light_trail);
           
         // 1 indicates to turn right
         else
           change_right(light_trail);
   
       }
     }
  }
    
  // Method used for changing AI racer upwards
  void change_up(boolean[][] light_trail){
    // Check if it is safe to turn up
    if(check_up(light_trail))
      vy = -speed;  
           
    // If not safe, check if safe to turn down instead
    else if(check_down(light_trail))
      vy = speed;        
      
    vx = (vy != 0) ? 0 : vx;
  }
  
  // Method used for changing AI racer downwards
  void change_down(boolean[][] light_trail){
    // Check if safe to turn down
    if(check_down(light_trail))
      vy = speed;
      
    // Else, check if safe to turn up instead
    else if(check_up(light_trail))
      vy = -speed;
      
      
    vx = (vy != 0) ? 0 : vx;
  }
  
  // Method used for changing AI racer to the left
  void change_left(boolean[][] light_trail){
   // Check if safe to turn left
   if(check_left(light_trail))
     vx = -speed;

   // Else, check if safe to turn right instead
   else if(check_right(light_trail))
     vx = speed;
     
   vy = (vx != 0) ? 0 : vy;
  }
  
  
  // Method used for changing AI racer to the right
  void change_right(boolean[][] light_trail){
    // Check if safe to turn right
    if(check_right(light_trail))
      vx = speed;
    
    // Else, check if afe to turn left instead
    else if(check_left(light_trail))
      vx = -speed;
       
    vy = (vx != 0) ? 0 : vy;
  }

  
  // Method for detecting if a racer has encountered an obstacle or if there is an obstacle in the AI's path
  void check_obstacles(boolean[][] light_trail){
     
    // Check a range of pixels in front of car
    for(int i = 0; i < 50; ++i){
       
      // Check if car is traveling in x-direction and obstacle is within the range in front of car
      if(vx != 0 && vy == 0 && x+i < light_trail.length && x-i >= 0){   
         
        // Check if car is moving in positive x-direction and there is an obstical/wall
        if(vx > 0 && (light_trail[x+i][y] == true || x+i == light_trail.length-1)){       
           int direction = (int)random(2);   // Generate a random number to simulate a random direction choice
           if(direction == 0)
             change_up(light_trail);   // 0 indicates to turn up
           else
             change_down(light_trail);   // 1 indicates to turn down
        }

        // Check if car is moving in negative x-direction and there is an obstical/wall
        else if(vx < 0 && (light_trail[x-i][y] == true || x-i == 0)){ 
           int direction = (int)random(2);   // Generate a random number to simulate a random direction choice
           if(direction == 0)
             change_up(light_trail);   // 0 indicates to turn up
           else
             change_down(light_trail);   // 1 indicates to turn down
        }
      }
        
      // Check if car is travling in y-direction and obstacle is within random in front of car  
      else if(vy != 0 && vx == 0 && y+i < light_trail[0].length && y-i >= 0){
        
        // Check if car is moving in positive y-direction and there is an obstical/wall
        if(vy > 0 && (light_trail[x][y+i] == true || y+i == light_trail[0].length-1)){ 
           int direction = (int)random(2);   // Generate random number to simulate random direction chosen by computer
           if(direction == 0)
             change_left(light_trail);   // 0 indicates to turn left
           else
             change_right(light_trail);   // 1 indicates to turn right
        }
       
        // Check if car is moving in negative y-direction and there is an obstical/wall
        else if(vy < 0 && (light_trail[x][y-i] == true || y-i == 0)){
           int direction = (int)random(2);   // Generate random number to simulate random direction chosen by computer
           if(direction == 0)
             change_left(light_trail);   // 0 indicates to turn left
           else
             change_right(light_trail);   // 1 indicates to turn right
        }
      }
    }
  }
  
  // Boolean method that checks if its safe for a racer to turn left. It uses the light trail array to detect if there would be anything its path, and returns a boolean representing if it would be a safe choice.
  boolean check_left(boolean[][] light_trail){
    // Check up to 30 pixels to the left of the racer
    for(int i = 0; i < 50; ++i)
     if(x-i >= 0)
       if(light_trail[x-i][y])
         return false;   // If there are any obstacles in the path, indicate that the racer should not turn
       
     return true;   // Else, indicate that it is safe for the racer to turn
  }
  
  // Boolean method that checks if its safe for a racer to turn right. It uses the light trail array to detect if there would be anything its path, and returns a boolean representing if it would be a safe choice.
  boolean check_right(boolean[][] light_trail){
    // Check up to 30 pixels to the left of the racer
    for(int i = 0; i < 50; ++i)
     if(x + i < light_trail.length-1)
       if(light_trail[x+i][y])
         return false;   // If there are any obstacles in the path, indicate that the racer should not turn
       
     return true;   // Else, indicate that it is safe for the racer to turn
  }
  
  // Boolean method that checks if its safe for a racer to turn up. It uses the light trail array to detect if there would be anything its path, and returns a boolean representing if it would be a safe choice.
  boolean check_up(boolean[][] light_trail){
    // Check up to 30 pixels to the left of the racer
    for(int i = 0; i < 50; ++i)
     if(y-i >= 0)
      if(light_trail[x][y-i])
        return false;   // If there are any obstacles in the path, indicate that the racer should not turn
       
     return true;   // Else, indicate that it is safe for the racer to turn
  }
  
  // Boolean method that checks if its safe for a racer to turn left. It uses the light trail array to detect if there would be anything its path, and returns a boolean representing if it would be a safe choice.
  boolean check_down(boolean[][] light_trail){
    // Check up to 30 pixels to the left of the racer
    for(int i = 0; i < 50; ++i)
     if(y+i < light_trail[0].length-1)
       if(light_trail[x][y+i])
       return false;   // If there are any obstacles in the path, indicate that the racer should not turn
       
     return true;   // Else, indicate that it is safe for the racer to turn
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
    
    void press_key(){
      return;
    }
}
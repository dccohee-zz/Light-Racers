class Racer{
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
  
  // CONSTRUCTORS:
  // Default Constructor
  Racer(){
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
  }
  
  // Overloaded Constructor
  Racer(color c, int start_x, int start_y, int car_width, float speed, float vx, float vy){
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
  
    
  void check_collision(boolean[][] light_trail){    
    boolean collision = false;
    
    // Check if car has extended beyond boundaries of wall
    if(x < 0 || y < 0 || x >= light_trail.length || y >= light_trail[0].length)
      collision = true;
    
    
    // Check if car has run into obstical
    else if(light_trail[x][y] == true)
      collision = true;

    // If a collision occurred
    if(collision){
      --lives;   // Diminish number of lives 
      respawn(light_trail);   // Respawn car
    }
}
  
  
  /* Method for controling the AI cars. It detects if an obstical or light trail is in its path, and changes directions accordingly.*/
  void check_AI(boolean[][] light_trail){
    if(x < 0 || y < 0 || x > light_trail.length || y > light_trail[0].length)
      return; 
      
    // Check a range of pixels in front of car
    for(int i = 0; i < 30; ++i){
       
      // Check if car is traveling in x-direction and obstical is within the range in front of car
      if(vx != 0 && vy == 0 && x+i < light_trail.length && x-i >= 0){   
         
        // Check if car is moving in positive x-direction and there is an obstical/wall
        if(vx > 0 && (light_trail[x+i][y] == true || x+i == light_trail.length-1)){       
           int direction = (int)random(2);   // Generate a random number to simulate a random direction choice
           vx = 0;   // Stop moving in x-direction;
           vy = (direction == 0) ? speed : -speed;   // Move in randomly chosen y-direction
        }

        // Check if car is moving in negative x-direction and there is an obstical/wall
        else if(vx < 0 && (light_trail[x-i][y] == true || x-i == 0)){ 
           int direction = (int)random(2);   // Generate a random number to simulate a random direction choice
           vx = 0;   // Stop moving in x-direction;
           vy = (direction == 0) ? speed : -speed;   // Move in randomly chosen y-direction
        }
      }
        
      // Check if car is travling in y-direction and obstical is within random in front of car  
      else if(vy != 0 && vx == 0 && y+i < light_trail[0].length && y-i >= 0){
        
        // Check if car is moving in positive y-direction and there is an obstical/wall
        if(vy > 0 && (light_trail[x][y+i] == true || y+i == light_trail[0].length-1)){ 
           int direction = (int)random(2);   // Generate random number to simulate random direction chosen by computer
           vy = 0;   // Stop moving in y-direciton
           vx = (direction == 0) ? speed : -speed;   // Move in x-direction based on randomly chosen number
        }
       
        // Check if car is moving in negative y-direction and there is an obstical/wall
        else if(vy < 0 && (light_trail[x][y-i] == true || y-i == 0)){
           int direction = (int)random(2);   // Generate random number to simulate random direction chosen by computer
           vy = 0;   // Stop moving in y-direciton
           vx = (direction == 0) ? speed : -speed;   // Move in x-direction based on randomly chosen number
        }  
        
      }
    }
  }
  
  // Function for randomly changing AI direction to give it a more human-feeling.
  void update_AI(boolean[][] light_trail){
     int change = (int)random(500);   // Generate a random number to determine if to change direction
     
     // If a certain number is generated, randomly change direction
     if(change == 1){
       // If moving in the x-direction
       if(vx != 0 && vy == 0) {
         // Randomly shift to moving in the y-direction
         int direction = (int)random(2);
         vx = 0;
         vy = (direction == 0) ? speed : -speed;         
       }
       
       // If moving in the y-direction
       else if(vx == 0 && vy != 0) {
         // Randomly shift to moving in the x-direction
         int direction = (int)random(2);
         vy = 0;
         vx = (direction == 0) ? speed : -speed;
       }
     }
  }
  
  
  
  // Change car's direction based on key stroke
  void press_key(){
    // Up arrow key is pressed:
    if(keyCode == UP){
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
    else if(keyCode == DOWN){
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
    else if(keyCode == LEFT){
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
    else if(keyCode == RIGHT){
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
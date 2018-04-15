class Racer{
  // DATA MEMBERS:
  private color c;   // Color of car
  private int x, y;   // Position of car on grid
  private int start_x, start_y;   // Initial spawn position of car 
  private int car_width;    // Width of car
  private float vx, vy;   // Speed of car
  private float speed; 
  private boolean destroyed;   // Boolean variable for if car is still alive
  
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
   destroyed = false;
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
    destroyed = false;
  }
  
  // METHODS:
  // Accessor and Mutator methods for data fields
  // Accessor for x-location
  int get_x(){ return this.x; }
  
  // Accessor for y-location
  int get_y(){  return this.y; }
  
  // Accessor for destroyed
  boolean get_destroyed(){  return this.destroyed; }  
  
  // Accessors for car width
  int get_width() { return this.car_width; }
  
  // Getter/Setter for color
  color get_color() { return this.c; }
  void set_color(color c) { this.c = c; }
  
  // Draw car
  void display(){
    rectMode(CENTER);
    fill(c);
    noStroke();
    rect(x, y, car_width, car_width);
  }
   
  // Update car's position based on speed
  void update(){
    x += vx;
    y += vy;
  }
  
    
  void check_collision(boolean[][] light_trail){
    if(x > 0 && y > 0){
      if(light_trail[x][y])
        destroyed = true;
      else
        light_trail[x][y] = true;
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
    void reset_car(){
      destroyed = false;
      vy = speed;
      vx = 0;
      x = start_x; 
      y = start_y;
    }
}
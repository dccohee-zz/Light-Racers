class Racer{
  // DATA MEMBERS:
  private color c;   // Color of car
  private int x, y;   // Position of car on grid
  private float vx, vy;   // Speed of car
  private float speed; 
  private boolean destroyed;   // Boolean variable for if car is still alive
  
  // CONSTRUCTORS:
  // Default Constructor
  Racer(){
   x = 30;
   y = 25;
   c = color(#002BFA);
   speed = 3;
   vx = 0;
   vy = speed;
   destroyed = false;
  }
  
  // Overloaded Constructor
  Racer(color c, int x, int y, float speed, float vx, float vy){
    this.c = c;
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.vx = vx;
    this.vy = vy;
    destroyed = false;
  }
  
  // METHODS:
  // Accessor for x-location
  int get_x(){ return this.x; }
  
  // Accessor for y-location
  int get_y(){  return this.y; }
  
  // Accessor for destroyed
  boolean get_destroyed(){  return this.destroyed; }  
  
  // Draw car
  void display(){
    rectMode(CORNER);
    fill(c);
    noStroke();
    rect(x, y, 15, 15);
  }
   
  // Update car's position based on speed
  void update(){
    x += vx;
    y += vy;
  }
  
  // Method for checking if car is still within wall boundaries
  void check_wall(int w1, int h1, int w2, int h2){
     if(x < w1 || x > w2-15)
       destroyed = true;
     if(y < h1 || y > h2-15)
       destroyed = true;
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
    x = 30; 
    y = 25;
  }
}
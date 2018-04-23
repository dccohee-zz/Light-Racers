/*
Authors: Dalton Cale Cohee and Douglas Easom 
Date: 18 April 2018
Program: Light Racer: Racer Interface
Program Description: This program creates an abstract racer class that can be implemented in different ways for users and AI. Through creating a racer interface, all cars can be treated the same even if they are not of the same type. 
*/

interface Racer {
  
  // Getters/Setters for Data Fields:
  int get_x();
  int get_y();
  int get_width();
  color get_color();
  void set_color(color c); 
  float get_speed();
  void set_speed(float speed);
  int get_lives();
  void set_lives(int lives);
  
  void start_sound();   // Method for beginning driving sound effect
  void stop_sound();   // Method for ending driving sound effect
  
  void display();   // Method for drawing car
  void update(boolean[][] light_trail);   // Method for changing car's position. Inputs array to mark previous location as visited
  void check_collision(boolean[][] light_trail);   // Method for checking if racer runs into a 'visited' location
  void respawn(boolean[][] light_trail);   // Method for restarting car after collision
  void press_key();   // Method for controling racers using computer keys
  void reset();   // Method for restarting car to default values at the end of a round
}
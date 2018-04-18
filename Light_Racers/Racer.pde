interface Racer {
  
  int get_x();
  int get_y();
  int get_width();
  color get_color();
  void set_color(color c); 
  float get_speed();
  void set_speed(float speed);
  int get_lives();
  void set_lives(int lives);

  
  void display();
  void update(boolean[][] light_trail);
  void check_collision(boolean[][] light_trail);
  void respawn(boolean[][] light_trail);
  void press_key();
  void reset();
}
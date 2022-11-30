/* Renders a 3D sphere sphere made of points,
 * removing some parts so that it looks like Pac-Man.
 * Red lines are used as shape borders. */
 
void setup() {
  size(600, 600, P3D);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  
  // Rotate the shape according to the amount of time passed
  float t = frameCount / 100.0;
  rotateX(t);
  rotateY(t);
  rotateZ(t);
  
  int rad = 200;
  for (float a = 0; a < PI; a += TWO_PI/150) {
    /* Draws "rings" of points within a sphere.
     * Points are ignored if they are part of the mouth. */
     
    float z = cos(a) * rad;
    float r = sin(a) * rad;
    
    for (float theta = 0; theta < TWO_PI; theta += TWO_PI/50) {
      float x = r * cos(theta);
      float y = r * sin(theta);
      
      // Do not draw points where the mouth is open
      if (theta < TWO_PI/10 || theta > TWO_PI * 9/10)
        continue;
      
      // Points that are not inside the mouth,
      // but are on the edges, are connected to form the border
      if ( isclose(theta, TWO_PI * 9/10) ||
        isclose(theta, TWO_PI/10) ) {
          // same position, other side of the shape
          float zz = cos(a + PI) * rad;
          
          strokeWeight(5);
          stroke(255, 0, 0);
          line(x, y, z, x, y, zz);
      }
      
      strokeWeight(15);
      stroke(255, 255, 0);
      point(x, y, z);
    }

  }
  
}

boolean isclose(float a, float b) {
  /* returns if two numbers are almost the same. */
  return abs(a - b) < 0.15;
}

SpaceShip ship = new SpaceShip();
//Bullet bill = new Bullet(ship);

boolean wIsPressed = false;
boolean aIsPressed = false;
boolean sIsPressed = false;
boolean dIsPressed = false;

Star [] nightSky = new Star[140];
ArrayList <Asteroids> ast;
ArrayList <Bullet> blt;

public void setup() 
{
  ast = new ArrayList <Asteroids>();
  blt = new ArrayList<Bullet>();
  size(500,500);
  for (int starI = 0; starI < nightSky.length; starI++)
  {
    nightSky[starI] = new Star();
  }
  for (int astI = 0; astI < 7; astI ++)
  {
    ast.add(new Asteroids());
  }
}

public void draw() 
{
  background(0);
  for (int starI = 0; starI < nightSky.length; starI++)
  {
    nightSky[starI].show();
  }
  ship.show();
  ship.move();
  //bill.show();
  //bill.move();
  for(int nI = 0; nI < ast.size(); nI++)
  {
    Asteroids astList = ast.get(nI);
    astList.show();
    astList.move();
    for (int bI= 0; bI < blt.size(); bI++)
    {
      if (astList.getX() == blt.get(bI).getX() && astList.getY() == blt.get(bI).getY())
      {
        ast.remove(bI);
        blt.remove(bI);
      }
    }
  }
  for (int nI = 0; nI < blt.size(); nI++)
  {
    Bullet bltList = blt.get(nI);
    bltList.show();
    bltList.move();
  }
}

class Star
{
  private int myX, myY;

  public Star()
  {
    myX = (int)(Math.random()*500);
    myY = (int)(Math.random()*500);
  }

  public void show()
  {
    fill((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255));
    noStroke();
    beginShape();
    vertex(myX, myY - 2);
    vertex(myX + 2, myY);
    vertex(myX, myY + 2);
    vertex(myX - 2, myY);
    endShape(CLOSE);
  }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();   
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }
}

class SpaceShip extends Floater  
{   
  //your code here
  SpaceShip ()
  {
    myColor = 255;
    myCenterX = 250;
    myCenterY = 250;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
    corners = 4;
    xCorners = new int[corners];
    yCorners = new int[corners];

    xCorners[0] = -4;
    yCorners[0] = 8;

    xCorners[1] = 9;
    yCorners[1] = 0;

    xCorners[2] = -4;
    yCorners[2] = -8;

    xCorners[3] = -11;
    yCorners[3] = 0;
  }

  public void setX(int x) {myCenterX = x;}  
  public int getX() {return (int)myCenterX;}

  public void setY(int y) {myCenterY = y;}   
  public int getY() {return (int)myCenterY;}

  public void setDirectionX(double x) {myDirectionX = x;}   
  public double getDirectionX() {return myDirectionX;}

  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}

  public void setPointDirection(int degrees) {myPointDirection = degrees;}   
  public double getPointDirection() {return myPointDirection;}
}

void keyPressed()
{
  if (key == 'w') {wIsPressed = true;}
  if (key == 'a') {aIsPressed = true;}
  if (key == 's') {sIsPressed = true;}
  if (key == 'd') {dIsPressed = true;}

  //rotate
  if(aIsPressed == true) { ship.rotate(-5); }
  if(dIsPressed == true) { ship.rotate(5); }

  //Accelerate/decelerate
  if(wIsPressed == true) { ship.accelerate(0.15); }
  if(sIsPressed == true) { ship.accelerate(-0.15); }

  if(wIsPressed == true && aIsPressed == true)
    {
      ship.rotate(-5);
      ship.accelerate(0.15);
    }
  if(wIsPressed == true && dIsPressed == true)
    {
      ship.rotate(5);
      ship.accelerate(0.15);
    }
  if(sIsPressed == true && aIsPressed == true)
    {
      ship.rotate(-5);
      ship.accelerate(-0.15);
    }
  if(sIsPressed == true && dIsPressed == true)
    {
      ship.rotate(5);
      ship.accelerate(-0.15);
    }
  //hyperspace
  if (key =='h')
  {
    ship.setX((int)(Math.random()*500));
    ship.setY((int)(Math.random()*500));
    ship.setDirectionX(0);
    ship.setDirectionY(0);
    ship.setPointDirection((int)(Math.random()*360));
  }
  if (key ==' ')
  {
    blt.add(new Bullet(ship));
  }
}

class Bullet extends Floater
{
  Bullet(SpaceShip ship)
  {
    myCenterX = ship.getX();
    myCenterY = ship.getY();
    myPointDirection = ship.getPointDirection();
    double dRadians =myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + ship.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + ship.getDirectionY();
  }
  public void setX(int x) {myCenterX = x;}  
  public int getX() {return (int)myCenterX;}

  public void setY(int y) {myCenterY = y;}   
  public int getY() {return (int)myCenterY;}

  public void setDirectionX(double x) {myDirectionX = x;}   
  public double getDirectionX() {return myDirectionX;}

  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}

  public void setPointDirection(int degrees) {myPointDirection = degrees;}   
  public double getPointDirection() {return myPointDirection;}
  public void show()
  {
    ellipse((float)myCenterX, (float)myCenterY, 5, 5);
  }
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;
  }
}

void keyReleased()
{
  if(key=='w')
  {
    wIsPressed = false;
  }
  else if (key == 'a')
  {
    aIsPressed = false;
  }
  else if (key == 's')
  {
    sIsPressed = false;
  }
  else if (key == 'd')
  {
    dIsPressed = false;
  }
}

class Asteroids extends Floater
{
  private int rotSpeed;
  Asteroids()
  {
    myColor = 128;
    myCenterX = (int)(Math.random()*500);
    myCenterY = (int)(Math.random()*500);
    rotSpeed = (int)(Math.random()*5);
    myDirectionX = Math.random()*2;
    myDirectionY = Math.random()*2;

    if (Math.random() < 0.5)
    {
      rotSpeed = -1 * rotSpeed;
      myDirectionX = -1 * myDirectionX;
    }
    if (Math.random() < 0.5)
    {
      myDirectionY = -1 * myDirectionY;
    }

    corners = 8;
    xCorners = new int[corners];
    yCorners = new int[corners];

    xCorners[0] = -3;
    yCorners[0] = 18;

    xCorners[1] = 6;
    yCorners[1] = 15;

    xCorners[2] = 12;
    yCorners[2] = 6;

    xCorners[3] = 9;
    yCorners[3] = -6;

    xCorners[4] = 3;
    yCorners[4] = -12;

    xCorners[5] = -12;
    yCorners[5] = -3;

    xCorners[6] = -12;
    yCorners[6] = 6;

    xCorners[7] = -9;
    yCorners[7] = 12;
  }

  public void setX(int x) {myCenterX = x;}  
  public int getX() {return (int)myCenterX;}

  public void setY(int y) {myCenterY = y;}   
  public int getY() {return (int)myCenterY;}

  public void setDirectionX(double x) {myDirectionX = x;}   
  public double getDirectionX() {return myDirectionX;}

  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}

  public void setPointDirection(int degrees) {myPointDirection = degrees;}   
  public double getPointDirection() {return myPointDirection;}

  public void move()
  {
    rotate(rotSpeed);
    super.move();
  }
}
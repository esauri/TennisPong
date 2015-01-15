Paddle myPaddle;
Ball tennisball;
Court tenniscourt;
Scoreboard board;
Gameover screen;
Startscreen begin;

boolean isgameover; //Boolean tests if Game is over or not

boolean starting=true; //If playing game is true

//Booleans that test if Paddle should move Vertically
boolean player1UP, player1DOWN;
boolean player2UP, player2DOWN;

//Booleans that check if Player is pressing the serving key
boolean player1SERVEKEY;
boolean player2SERVEKEY;

//Boolean to serve ball
boolean player1SERVE;
boolean player2SERVE;

boolean p1win;
boolean p2win;

String p1="Player One:";
String p2="Player Two:";

int score1; //Player one's score
int score2; //Player two's score

boolean isscorenum; //Is the score a number?
boolean isp10=true; //Is player one's score 0
boolean isp20=true; //Is player two's score a 0

int point=15;
int pnt=10;

float acceleration=.5;

float sz=500;
float ww4= sz-(sz/4);
float sz2= sz/2;
float sz4= sz2/2;

String l="Love";
PFont font;
PFont font2;
PVector velocity= new PVector(); //Ball's speed

void setup()
{

  size(500, 500);
  smooth();


  board= new Scoreboard();
  begin= new Startscreen();
  screen= new Gameover();
  myPaddle= new Paddle();
  tennisball= new Ball();
  tenniscourt= new Court();


  font=loadFont("AgencyFB-Reg-48.vlw");
  font2=loadFont("ArialNarrow-Bold-48.vlw");

  //Player1 (left) always serves first

    player1SERVE=true;
}

void draw() 
{


  if (starting == true)
  {
    background(#669933);
    begin.render();
    myPaddle.move();
    myPaddle.render();

    if (mouseX>390 && mouseY>390 && mouseX<width && mouseY <height)
    {
      sig(390, 390, 490, 490); //Displays sig
    }
  }

  else if (isgameover == false && starting == false)
  {
    background(#669933);
    tenniscourt.render();
    board.render();
    serve(); //Function for serving the ball
    collision(); //Function for detecting collision between Objects and wall
    tennisball.render();
    myPaddle.move();
    myPaddle.render();

    noCursor();
  }

  else 
  {

    screen.whowins();
    screen.render();
    cursor();
  }
}

void serve()
{
  //What happens if it is Player 1's turn to serve
  if (player1SERVE) 
  {
    tennisball.ball.x= myPaddle.playerone.x+myPaddle._width/2+tennisball.ballradius; //the balls position in X axis is equal to the paddle's position in X axis minus half of the paddle's width minus the ball's radius
    tennisball.ball.y=myPaddle.playerone.y; //the balls position in Y axis equals the paddle's Y postion
    velocity.x=0; //start at rest
    velocity.y=0; //start at rest

    if (player1SERVEKEY) 
    { 
      velocity.x=3; //accelerate 
      velocity.y=random(-3, 3);

      player1SERVE=false; //player 1 can no longer serve
    }
  }
  //=========================================
  ////What happens if it is Player 2's turn to serve
  else if (player2SERVE)  
  {
    tennisball.ball.x=myPaddle.playertwo.x-myPaddle._width/2-tennisball.ballradius; //the balls position in X axis is equal to the paddle's position in X axis minus half of the paddle's width minus the ball's radius
    tennisball.ball.y=myPaddle.playertwo.y; //the balls position in Y axis equals the paddle's Y postion
    velocity.x=0; //start at rest
    velocity.y=0; //start at rest

    if (player2SERVEKEY)
    { 
      velocity.x=-3; //deccelerate or accelerate towards the left
      velocity.y=random(-3, 3);

      player2SERVE=false; //player 2 can no longer serve
    }
  }
}

//Checks what happens when ball comes into contact with Paddle, Floor, ceiling or goes out of bounds
void collision()
{
  //If it touches the ceiling bounce
  if (tennisball.ball.y-tennisball.ballradius<0) {
    velocity.y=-velocity.y;
    tennisball.ball.y=tennisball.ballradius;
  }

  //If ball touches floor bounce
  else if (tennisball.ball.y+tennisball.ballradius>height) 
  {   
    velocity.y=-velocity.y;
    tennisball.ball.y=height-tennisball.ballradius;
  }

  //If ball comes into contact with Player one BOUNCE!
  else if (abs(tennisball.ball.x-myPaddle.playerone.x)<=tennisball.ballradius+(myPaddle._width/2) && //If the absolute value of balls position in X minus the paddle's X position is less or equal to the ball's radius plus half of the paddle's width
  abs( tennisball.ball.y-myPaddle.playerone.y)<= myPaddle.center && //and if the absolute value of balls position in Y minus the paddle's Y position is less or equal to the paddle's center 
  velocity.x<0) // and the velocity in the X axis is greater than zero, then the Ball is touching Player 1
  { 
    tennisball.b=#CB9200;
    velocity.x=2+acceleration; //Bounce ball
    acceleration+=.5;

    if (acceleration>6)
    {
      acceleration=1;
    }
  }

  //If ball touches player 2 bounce
  else if (abs(tennisball.ball.x-myPaddle.playertwo.x)<=tennisball.ballradius+myPaddle._width/2 && //If the absolute value of balls position in X minus the paddle's X position is less or equal to the ball's radius plus half of the paddle's width
  abs( tennisball.ball.y-myPaddle.playertwo.y)<= myPaddle.center && //and if the absolute value of balls position in Y minus the paddle's Y position is less or equal to the paddle's center 
  velocity.x>0) // and the velocity in the X axis is greater than zero, then the Ball is touching Player 2
  { 
    tennisball.b=#cccc00;
    velocity.x=-2-acceleration; //Bounce ball

    acceleration+=.5;

    if (acceleration>6)
    {
      acceleration=1;
    }
  }

  //If it goes out of bounds on the left side, Player 1's turn to serve now 
  else if (tennisball.ball.x<0) 
  { 
    player1SERVE=true;
    player2SERVE=false;


    if (score2>=0 && score2<20) 
    {
      isp20=false; //Player score is not 0
      score2+=point; //Add 15 to score
    }

    else if (score2==30 && score2<35)
    {
      score2+=pnt; //Add ten to score
    }

    else if (score2 == 40)
    {
      isgameover=true; //Game is over
      p2win=true; //Player 2 Wins
    }
  }

  //If it goes out of bounds on the right side, Player 2's turn to serve 
  else if (tennisball.ball.x>width)
  {
    player1SERVE=false;
    player2SERVE=true;

    if (score1>=0 && score1<20)
    {
      isp10=false; //Player score is not 0
      score1+=point; //Add 15 to score
    }

    else if (score1==30 && score1<45)
    {
      score1+=pnt; //Add 10 to score
    }

    else if (score1 == 40)
    {
      isgameover=true; //Game is Over
      p1win=true; //Player 1 wins
    }
  }

  //Ball moves, its position equals itself plus velocity in x or y axis
  else 
  {
    tennisball.ball.x=tennisball.ball.x+velocity.x;
    tennisball.ball.y=tennisball.ball.y+velocity.y;
  }
}

//What happens when you press a key 
//Player 1 keys: W (move up), S (move down), D (Serve ball)
//Player 2 keys: UP arrow (move up), DOWN arrow (move down), LEFT arrow (serve)
void keyPressed() 
{

  if (key=='w'||key=='W' ) { //When 'W' key is pressed then player can move up

    player1UP=true;
  }

  else if (key=='s'||key=='S') { //When 'S' key is pressed then player can move down

    player1DOWN=true;
  }

  if (key=='d'||key=='D') { //When 'D' key is pressed Player can serve ball
    player1SERVEKEY=true;
  }

  if (keyCode==UP) { //When 'UP' key is pressed then player can move up
    player2UP=true;
  }

  if (keyCode==DOWN) { //When 'DOWN' key is pressed then player can move down
    player2DOWN=true;
  }

  if (keyCode==LEFT) { //When 'LEFT' key is pressed Player can serve ball
    player2SERVEKEY=true;
  }
}

//Set booleans to false to stop movement
void keyReleased()
{

  if (key=='w'||key=='W') {  //When 'W' is released Player 1 can not move Up

    player1UP=false;
  }

  else if (key=='s'||key=='S') { //When 'S' is released Player can not move Down

    player1DOWN=false;
  }

  if (key=='d'||key=='D') { //When 'D' is released Player 1 is not serving
    player1SERVEKEY=false;
  }

  if (keyCode==UP) { //When 'UP' is released Player 2 can not move Up
    player2UP=false;
  }

  if (keyCode==DOWN) { //When 'DOWN' is released Player 2 can not move Down
    player2DOWN=false;
  }

  if (keyCode==LEFT) {
    player2SERVEKEY=false; //When 'LEFT' is released Player 2 is not serving
  }
}


void mousePressed()
{
  begin.mousePressed();
  screen.mousePressed();
}

void sig(float x, float y, float w, float h)
{
  /*fill(0);
   rect(x, y, w, h);*/

  noStroke();
  fill(#505483);


  ellipseMode(CORNER);
  ellipse(x+40, y+20, 40, 10);


  rectMode(CORNERS);
  rect(x+40, y+25, x+50, y+70);


  ellipseMode(CORNER);
  ellipse(x+55, y+40, 10, 10);

  rectMode(CORNERS);
  rect(x+50, y+40, x+60, y+50);

  //J

  ellipseMode(CORNER);
  ellipse(x+40, y+65, 40, 10);

  rectMode(CORNERS);
  rect(x+60, y+70, x+70, y+100);

  rect(x+45, y+110, x+70, y+100);


  //rect(x+80, y+75, x+85, y+100);
}

/*
By Erick Sauri
 */

class Ball
{
  PVector ball = new PVector(); //Ball's X&Y postion

  float ballradius; //Radius of ball
  color b=#CB9200;

  Ball()
  {
    ballradius=8;
    ball.x=myPaddle.playerone.x+(myPaddle._width/2)+ballradius; //X position begins at the center of Player 1's paddle
    ball.y=myPaddle.playerone.y; //Y position is the same as the paddle's
  }

  void render()
  {
    noStroke();
    fill(b);
    ellipse(ball.x, ball.y, ballradius*2, ballradius*2);
  }
}

class Court
{
  float w15;
  float h15;
  float w45;
  float h45;
 

  Court()
  {
    w15=sz-15;
    h15=sz-15;

    h45=sz-45;
    
  }

  void render()
  {
    stroke(255);

    line(15, 15, w15, 15);
    line(15, 45, w15, 45);

    line(15, 15, 15, h15);
    line(w15, 15, w15, h15);

    line(15, h15, w15, h15);
    line(15, h45, w15, h45);

    line(sz2, 15, sz2, h15);

    line(sz4, 45, sz4, h45);
    line(ww4, 45, ww4, h45);
    line(sz4, sz2, ww4, sz2);

    line(15, sz2, 20, sz2);
    line(sz-15, sz2, sz-20, sz2);
    
    
  }
}

class Gameover
{
  PVector replaypos= new PVector();
  PVector exitpos= new PVector();

  Gameover()
  {
    replaypos.x=90; //90,160
    replaypos.y=350; //350,380

    exitpos.x=340; //340,410
    exitpos.y=350; //350,380
  }

  void render()

  {
    stroke(255);
    noFill();
    rectMode(CORNER);
    rect(replaypos.x, replaypos.y, 70, 30);
    rect(exitpos.x, exitpos.y, 70, 30);

    fill(0);
    textFont(font, 16);
    text("Play Again", replaypos.x+10, replaypos.y+10, 150, 390);

    textFont(font, 16);
    text("Exit", exitpos.x+25, exitpos.y+10, 150, 390);
  }

  void whowins()
  {
    if (p1win == true)
    {
      background(209, 103, 103);
      textFont(font, 48);
      text("Game Over!", width/3, height/4);

      textFont(font, 32);
      text("Player One is the Winner!", width/4, height/2);
    }

    else if (p2win == true)
    {
      background(142, 146, 234);
      textFont(font, 48);
      text("Game Over!", width/3, height/4);

      textFont(font, 32);
      text("Player Two is the Winner!", width/4, height/2);
    }
  }


  void mousePressed() //If mouse clicks on box
  {
    if (mouseX>replaypos.x && mouseY>replaypos.y && mouseX<161) //Play Again
    {
      isgameover=false;
      score1=0;
      score2=0;
    }

    else if (mouseX>exitpos.x && mouseY>exitpos.y && mouseX<411 && mouseY<381) //Exit
    {
      exit();
    }
  }
}

class Paddle
{

  PVector playerone = new PVector(); //X&Y coordinate for left paddle
  PVector playertwo = new PVector(); //X&Y coordinate for right paddle

  float center; //Center of the paddle
  float _width; //Width of paddle
  float _height; //Height of paddle

  Paddle()
  {
    //Player One XY
    playerone.x=10;
    playerone.y=height/2;

    //Player Two XY
    playertwo.x=width-playerone.x;
    playertwo.y=playerone.y;

    //Player one and two's width
    _width=10;

    //Player one and two's height
    _height=(height/8);


    //Center of the Paddle
    center=(_height *.5);
  }

  void move()
  {
    //If booleans are true they move Up or Down

    if (player1UP == true) 
    {
      playerone.y-=2; //Move up 2 at a time

      if (playerone.y<=0)
      {
        playerone.y=0;
        // playerone.y=0+_height;
      }
    }

    if (player1DOWN == true) 
    {
      playerone.y+=2; //Move down 2 at a time
      if (playerone.y>=height)
      {
        playerone.y=height;
        //playerone.y=height-_height;
      }
    }

    if (player2UP == true) 
    {
      playertwo.y-=2; //Move up 2 at a time

      if (playertwo.y<=0)
      {
        playertwo.y=0;
        //playertwo.y=0+_height;
      }
    }

    if (player2DOWN == true) 
    {
      playertwo.y+=2; //Move down 2 at a time
      if (playertwo.y>=height)
      {
        playertwo.y=height;
        //playertwo.y=height-_height;
      }
    }
  }




  void render()
  {
    move();
    
    
    rectMode(CENTER);
    fill(209, 103, 103);
    rect(playerone.x, playerone.y, _width, _height);

   
    fill(142, 146, 234);
    rect(playertwo.x, playertwo.y, _width, _height);

  }
}

class Scoreboard
{
  Scoreboard()
  {
  }

  void render() //Display text
  {
   /* fill(#00C3CB, 230);
    rectMode(CORNERS);
    rect(180, 10, 330, 50);*/

    fill(0);
    textFont(font2,16);
    text(p1, 155, 30);
    text(p2, 260, 30);
    
    if (isp10==true && isp20 == true) //if both players are at 0
    {
      text(l, 155, 45);
      text(l, 260, 45);
    }
    else if (isp10 == true && isp20 == false) //if playerone is at 0 but not player two
    { 
      text(l, 155, 45);
      text(score2, 260, 45);
    }
    else if (isp10 == false && isp20 == true) //if player two is at 0 but not player one
    {
      text(score1, 155, 45);
      text(l, 260, 45);
    }
    else if (isp10 == false && isp20 == false) //if none are at 0 points
    {
      text(score1, 155, 45);
      text(score2, 260, 45);
    }
   
  }
}


class Startscreen
{

  PVector playpos= new PVector();
  PVector exitpos= new PVector();

  Startscreen()
  {
    playpos.x=90; //90,160
    playpos.y=350; //350,380

    exitpos.x=340; //340,410
    exitpos.y=350; //350,380
  }

  void render()
  {

    stroke(255);
    noFill();
    rectMode(CORNER);
    rect(playpos.x, playpos.y, 70, 30);
    rect(exitpos.x, exitpos.y, 70, 30);

    fill(0);
    textFont(font, 16);
    text("Play Game", playpos.x+10, playpos.y+10, 150, 390);

    textFont(font, 16);
    text("Exit", exitpos.x+25, exitpos.y+10, 150, 390);


    textFont(font, 48);
    text("Tennis Pong", 150, 20, 340, 80);

    textFont(font, 32);
    text("Instructions:", 30, 170);
    textFont(font2, 20);
    text("Move Player One (Red) up and down with the 'W' and 'S' keys. Move Player Two (Blue) with the Up and Down Arrow keys. To put the ball into play, Player One must use the 'D' key and Player Two the Left Arrow key. First Player to score more than 40 points wins.", 30, 200, 440, 330);
  }

  void mousePressed() //If mouseclicks on box then...
  {
    if (mouseX>playpos.x && mouseY>playpos.y && mouseX<161) //...Play Game
    {
      starting=false;
    }

    else if (mouseX>exitpos.x && mouseY>exitpos.y && mouseX<411 && mouseY<381) //...Exit Program
    {
      exit();
    }
  }
}



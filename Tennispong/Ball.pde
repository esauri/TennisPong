
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


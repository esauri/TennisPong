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


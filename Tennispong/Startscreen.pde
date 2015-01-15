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


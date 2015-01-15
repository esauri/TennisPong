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


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



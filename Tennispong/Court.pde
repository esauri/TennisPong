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


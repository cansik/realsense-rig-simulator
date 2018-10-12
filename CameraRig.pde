class CameraRig
{
  // rig specifics
  float rigWidth = 2000;
  float rigLength = 2000;
  float rigHeight = 2000;

  // design
  color rigColor = color(20, 20, 20);
  float rigWeight = 2f; 

  RealSenseCamera[] cams;

  public CameraRig(int cameraCount)
  {
    cams = new RealSenseCamera[cameraCount];
  }

  public void initRig()
  {
    for (int i = 0; i < cams.length; i++)
    {
      RealSenseCamera rs = new RealSenseCamera();
      rs.flipped = true;
      cams[i] = rs;
    }
  }

  public void render(PGraphics g)
  {
    g.pushMatrix();

    // render rig
    noFill();
    stroke(rigColor);
    strokeWeight(rigWeight);

    // box
    box(rigWidth, rigLength, rigHeight);

    // attach bar
    box(rigWidth, rigLength, 2);

    // render cams
    float anglePerCam = 360f / cams.length;
    for (int i = 0; i < cams.length; i++)
    {
      g.pushMatrix();

      g.rotateZ(radians(anglePerCam * i));
      g.translate(rigWidth / 2, 0);

      cams[i].render(g);
      g.popMatrix();
    }

    g.popMatrix();
  }
}

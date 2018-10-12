class CameraRig
{
  // rig specifics


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

      cams[i] = rs;
    }
  }

  public void render(PGraphics g)
  {
    g.pushMatrix();

    // render
    for (RealSenseCamera rs : cams)
    {
      rs.render(g);
    }

    g.popMatrix();
  }
}

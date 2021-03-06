class RealSenseCamera
{
  // camera specs
  float cameraWidth = 25;
  float cameraHeight = 25;
  float cameraLength = 90;

  float lensSize = 10;

  float minRange = 105;
  float maxRange = 3.0 * 1000;

  int ventCount = 15;
  float ventWidth = 0.5;
  float ventHeight = 0.1;

  float horizontalDepthFieldOfView = 85;
  float verticalDepthFieldOfView = 58;

  // frustums
  PShape depthFrustum = createCameraFrustum(horizontalDepthFieldOfView, verticalDepthFieldOfView, minRange, maxRange);

  // design
  color bodyColor = color(194, 195, 199);
  color frontColor = color(20, 20, 20);
  color lensColor = color(50, 50, 50);
  color ventColor = color(10, 10, 10);

  color depthFrustumColor = color(255, 215, 0);
  float depthFrustumWeight = 1;

  // position
  boolean flipped = false;
  boolean isVertical = false;

  public RealSenseCamera()
  {
  }

  void render(PGraphics g)
  {
    pushMatrix();

    if (flipped)
    {
      g.rotateZ(radians(180));
    }

    if (isVertical)
    {
      g.rotateX(radians(90));
    }

    renderCamera();
    renderDepthFrustum();

    g.popMatrix();
  }

  void renderDepthFrustum()
  {
    // hacky way -> todo: makes this more performant
    //depthFrustum = createCameraFrustum(horizontalDepthFieldOfView, verticalDepthFieldOfView, minRange, maxRange);

    g.pushMatrix();
    g.rotateY(radians(90));
    g.rotateZ(radians(90));

    g.noFill();
    //g.fill(depthFrustumColor, 20);
    g.stroke(depthFrustumColor);
    g.strokeWeight(depthFrustumWeight);

    g.shape(depthFrustum);

    g.popMatrix();
  }

  void renderCamera()
  {
    // draw camera
    g.pushMatrix();

    g.translate(-1 * (cameraWidth / 2), 0);

    // body
    g.noStroke();
    g.fill(bodyColor);
    g.box(cameraWidth, cameraLength, cameraHeight);

    // lense
    g.pushMatrix();
    g.translate((cameraWidth / 2) - (lensSize * 0.8), 0);

    g.noStroke();
    g.fill(lensColor);
    g.sphereDetail(8);

    // right
    g.pushMatrix();
    g.translate(0, (cameraLength / 2) * 0.60);
    g.sphere(lensSize);
    g.popMatrix();

    // left
    g.pushMatrix();
    g.translate(0, -1 * (cameraLength / 2) * 0.60);
    g.sphere(lensSize);
    g.popMatrix();
    g.popMatrix();

    // ventilator rills
    g.pushMatrix();
    float ventLength = cameraLength * 0.9;
    float ventSpace = (ventLength - (ventWidth * ventCount)) / ventCount;

    g.noStroke();
    g.fill(ventColor);
    g.translate(0, -1 * (ventLength / 2));

    for (int i = 0; i < ventCount; i++)
    {
      g.pushMatrix();
      g.translate(0, i * (ventSpace + ventWidth));
      g.box(cameraWidth * 0.8, ventWidth, (ventHeight * 2) + cameraHeight);
      g.popMatrix();
    }

    g.popMatrix();
    g.popMatrix();
  }
}

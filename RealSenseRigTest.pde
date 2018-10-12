import peasy.PeasyCam;

PeasyCam cam;

CameraRig rig;

void setup()
{
  size(1024, 768, P3D);
  pixelDensity = 2;

  cam = new PeasyCam(this, 400);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(10000);

  // setting clipping pane far
  perspective(PI/3.0, (float)width/height, 1, 100000);

  rig = new CameraRig(4);
  rig.initRig();

  // so the frustums are transparent
  hint(DISABLE_DEPTH_TEST);
}

void draw()
{
  background(255);
  rig.render(g);
}

public PShape createCameraFrustum(float hAngle, float vAngle, float near, float far)
{
  PShape f = createShape();
  f.beginShape(QUADS);

  // calculate positions by polar coordinates
  PVector np = new PVector(near * cos(radians(hAngle) / 2), near * sin(radians(vAngle) / 2));
  PVector fp = new PVector(far * cos(radians(hAngle) / 2), far * sin(radians(vAngle) / 2));

  // near rect  
  f.vertex(-np.x, -np.y, near);
  f.vertex(np.x, -np.y, near);
  f.vertex(np.x, np.y, near);
  f.vertex(-np.x, np.y, near);

  // left rect
  f.vertex(np.x, np.y, near);
  f.vertex(fp.x, fp.y, far);
  f.vertex(fp.x, -fp.y, far);
  f.vertex(np.x, -np.y, near);

  // far rect
  f.vertex(-fp.x, -fp.y, far);
  f.vertex(fp.x, -fp.y, far);
  f.vertex(fp.x, fp.y, far);
  f.vertex(-fp.x, fp.y, far);

  // right rect
  f.vertex(-fp.x, -fp.y, far);
  f.vertex(-np.x, -np.y, near);
  f.vertex(-np.x, np.y, near);
  f.vertex(-fp.x, fp.y, far);

  // top rect
  f.vertex(np.x, np.y, near);
  f.vertex(-np.x, np.y, near);
  f.vertex(-fp.x, fp.y, far);
  f.vertex(fp.x, fp.y, far);

  //bottom rect
  f.vertex(-fp.x, -fp.y, far);
  f.vertex(fp.x, -fp.y, far);
  f.vertex(np.x, -np.y, near);
  f.vertex(-np.x, -np.y, near);

  f.endShape();
  f.disableStyle();
  return f;
}

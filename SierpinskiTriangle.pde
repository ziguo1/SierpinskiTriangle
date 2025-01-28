final int MIN_LENGTH = 20;
final color BG_COLOR = color(64, 64, 64);
final color FILL_COLOR = color(255, 255, 255);

PGraphics canvas;
CanvasViewer viewer;

void setup() {
  size(512, 512);
  canvas = createGraphics(512, 512);
  viewer = new CanvasViewer(canvas);
}



void draw() {
  canvas.beginDraw();
  canvas.background(BG_COLOR);
  drawFunnyTriangle(canvas, 256, 50, 256); // Start drawing triangles
  canvas.endDraw();
}

void drawFunnyTriangle(PGraphics ctx, int x, int y, int length) {
  if (length < MIN_LENGTH) {
    return;
  } else {
    int top = (int) ((length / 4) * Math.sqrt(3));
    int bottom = (int) ((length / 2) * Math.sqrt(3));
    int newLength = length / 2;
    ctx.fill(FILL_COLOR);
    
      {
        ctx.triangle(
          x, y,
          x - (length / 4), y + top,
          x + (length / 4), y + top
        );
        drawFunnyTriangle(ctx, x, y, newLength);
        ctx.triangle(
          x - (length / 4), y + top,
          x - (length / 2), y + bottom,
          x, y + bottom
        );
        drawFunnyTriangle(ctx, x - (length / 4), y + top, newLength);
        ctx.triangle(
          x + (length / 4), y + top,
          x + (length / 2), y + bottom,
          x, y + bottom
        );
        drawFunnyTriangle(ctx, x + (length / 4), y + top, newLength);
      }
      
      ctx.fill(BG_COLOR);
      ctx.triangle(
        x - (length / 4), y + top,
        x + (length / 4), y + top,
        x, y + bottom
      );
  }
}

class CanvasViewer {
  PGraphics ctx;
  int x, y;
  float scale;
  
  public CanvasViewer(PGraphics ctx) {
    this.ctx = ctx;
    this.x = ctx.width / 2;
    this.y = ctx.height / 2;
    this.scale = 1;
  }
  
public void drawToFrameBuffer() {
    background(BG_COLOR);
    pushMatrix();
    translate(x, y);
    scale(scale);
    image(ctx, -ctx.width/2, -ctx.height/2);
    popMatrix();
}
}

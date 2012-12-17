package moon.runes;

import android.graphics.Path;

/**
 * <insert some pithy quote about brushstrokes here>
 *
 * Essentially, a persistable version of android.gesture.GestureStroke
 */
class Stroke {
  public float[] points; // x,y positions of the points on the path

  Stroke(float[] points) {
    this.points = points;
  }

  Path getPath() {
    Path it = new Path();
    float mX = points[0];
    float mY = points[1];

    it.moveTo(mX, mY);

    for (int i = 2; i < points.length; i += 2) {
      float x = points[i];
      float y = points[i + 1];

      it.quadTo(mX, mY, (x + mX) / 2, (y + mY) / 2);
      mX = x;
      mY = y;
    }

    return it;
  }
}

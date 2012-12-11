package moon.runes

import android.graphics.Path

/**
 * <insert some pithy quote about brushstrokes here>
 *
 * Essentially, a persistable version of android.gesture.GestureStroke
 */
class Stroke {
  public val float[] points // x,y positions of the points on the path

  new(float[] points) {
    this.points = points
  }

  def getPath() {
    val it = new Path()
    var float mX = points.get(0); // XXX what the fuck Xtend
    var float mY = points.get(1);

    moveTo(mX, mY)

    var i = 2
    while (i < points.size) { // XXX can't use step size of 2 with ranges ...
      val x = points.get(i)
      val y = points.get(i + 1)

      quadTo(mX, mY, (x + mX) / 2, (y + mY) / 2)
      mX = x
      mY = y

      i = i + 2
    }

    it
  }
}
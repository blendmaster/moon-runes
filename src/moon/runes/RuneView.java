package moon.runes;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.Path;
import android.util.AttributeSet;
import android.view.View;

/**
 * "Stand by the grey stone when the thrush knocks and the setting sun with the
 * last light of Durin's Day will shine upon the key-hole."
 *
 * Draws the note's runes as "text", left-to-right order.
 */
class RuneView extends View {

  Note note;

  void setNote(Note note) {
    this.note = note;
    requestLayout(); // with new info
  }

  public RuneView(Context ctx, AttributeSet attrs, int defStyle) {
    super(ctx, attrs, defStyle);
  }

  RuneView(Context ctx, AttributeSet attrs) {
    super(ctx, attrs);
  }

  RuneView(Context ctx) {
    super(ctx);
  }

  // in px
  // TODO invalidate on Set
  int fontSize = 100;
  int lineHeight = 150;
  int letterSpacing = 110;
  int paddingLeft = 10;
  int paddingTop = 10;
  int color;
  // {
  // TypedValue tv = new TypedValue();
  // getCon.theme.resolveAttribute(android::R$attr::colorForeground, tv, true);
  // resources.getColor(tv.resourceId);
  // }

  // carriage position, as x offset
  int carriage = 0;


  private final Paint p = new Paint();
  private final Matrix toLetter = new Matrix();
  private final Path strokePaths = new Path();

  @Override
  protected
  void onDraw(Canvas c) {
    if (note == null) {
      return;
    }

    p.setColor(color);
    p.setStyle(Paint.Style.STROKE);
    p.setStrokeWidth(5);

    toLetter.setScale(fontSize, fontSize);
    toLetter.postTranslate(paddingLeft, paddingTop);

    carriage = 0;

    for (Rune rune : note.getRunes()) {

      strokePaths.rewind();
      for (Stroke stroke : rune.getStrokes()) {
        strokePaths.addPath(stroke.getPath(), toLetter);
      }
      c.drawPath(strokePaths, p);

      // move carriage
      toLetter.postTranslate(letterSpacing, 0);
      carriage += letterSpacing;
      if ((carriage + letterSpacing) > getWidth()) {
        toLetter.postTranslate(-carriage, 0); // carriage return
        carriage = 0;
        toLetter.postTranslate(0, lineHeight); // line feed
      }
    }
  }

  @Override
  protected
  void onMeasure(int widthSpec, int heightSpec) {
    // calculate full height necessary to display all the runes
    int calcHeight = paddingTop;

    int width = View.MeasureSpec.getSize(widthSpec);
    carriage = paddingLeft;
    for (int i = 0; i < note.getRunes().size(); i++) {
      carriage += letterSpacing;
      if ((carriage + letterSpacing) > width) {
        carriage = paddingLeft;
        calcHeight += lineHeight;
      }
    }

    setMeasuredDimension(width, calcHeight + lineHeight);
  }

}

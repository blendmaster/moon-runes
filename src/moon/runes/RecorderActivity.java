package moon.runes;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.gesture.Gesture;
import android.gesture.GestureOverlayView;
import android.gesture.GestureStroke;
import android.graphics.Matrix;
import android.graphics.RectF;
import android.os.Bundle;

import com.googlecode.androidannotations.annotations.EActivity;

/**
 * "I use the Pensieve. One simply siphons the excess thoughts from one's mind,
 * pours them into the basin, and examines them at one's leisure. It becomes
 * easier to spot patterns and links, you understand, when they are in this
 * form."
 */
@EActivity
class RecorderActivity extends Activity implements
    GestureOverlayView.OnGesturePerformedListener {

  Note note;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    note = new Note();
    MoonRunes.notes.add(note);

    GestureOverlayView it = new GestureOverlayView(this);
    it.addOnGesturePerformedListener(this);

    // be really lenient in what strokes to accept
    it.setGestureStrokeType(GestureOverlayView.GESTURE_STROKE_TYPE_MULTIPLE);
    it.setGestureStrokeAngleThreshold(1);
    it.setGestureStrokeSquarenessTreshold(0);
    this.setContentView(it);
  }

  // every stroke is normalized to this
  static RectF normalized = new RectF(0, 0, 1, 1);

  @Override
  public void onGesturePerformed(GestureOverlayView view, Gesture gesture) {
    RectF bounds = gesture.getBoundingBox();
    Matrix toNorm = new Matrix();
    toNorm.setRectToRect(bounds, normalized, Matrix.ScaleToFit.CENTER);

    // add strokes as Rune
    List<Stroke> strokes = new ArrayList<Stroke>();

    for (GestureStroke stroke : gesture.getStrokes()) {

      float[] normPoints = stroke.points;
      toNorm.mapPoints(normPoints);
      strokes.add(new Stroke(normPoints));
    }
    Rune r = new Rune(strokes);
    note.getRunes().add(r);
  }

  @Override
  protected void onPause() {
    ((MoonRunes)getApplication()).save();
    super.onPause();
  }

}

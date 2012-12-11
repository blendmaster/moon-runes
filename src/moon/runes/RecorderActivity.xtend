package moon.runes

import android.app.Activity
import android.gesture.Gesture
import android.gesture.GestureOverlayView
import android.gesture.GestureOverlayView$OnGesturePerformedListener
import android.graphics.Matrix
import android.graphics.Matrix$ScaleToFit
import android.graphics.RectF
import android.os.Bundle
import com.googlecode.androidannotations.annotations.EActivity
import java.util.ArrayList

import static android.gesture.GestureOverlayView.*
import static moon.runes.RecorderActivity.*

/**
 * "I use the Pensieve. One simply siphons the excess thoughts from one's 
 * mind, pours them into the basin, and examines them at one's leisure. 
 * It becomes easier to spot patterns and links, you understand, when 
 * they are in this form." 
 */
@EActivity
class RecorderActivity extends Activity 
implements GestureOverlayView$OnGesturePerformedListener {
  Note note

  override onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState)

    note = new Note
    // TODO real persistence
    MoonRunes::notes += note

    val it = new GestureOverlayView(this)
    addOnGesturePerformedListener(this)

    // be really lenient in what strokes to accept
    gestureStrokeType               = GESTURE_STROKE_TYPE_MULTIPLE
    gestureStrokeAngleThreshold     = 1
    gestureStrokeSquarenessTreshold = 0

    this.contentView = it
  }

  // every stroke is normalized to this
  static RectF normalized = new RectF(0, 0, 1, 1)

  override onGesturePerformed(GestureOverlayView view, Gesture gesture) {
    val bounds = gesture.boundingBox
    val toNorm = new Matrix
    toNorm.setRectToRect(bounds, normalized, Matrix$ScaleToFit::CENTER)

    // add strokes as Rune
    // XXX array list wrapper is to force execution of lazy map
    note.runes += new Rune(new ArrayList<Stroke>(gesture.strokes.map[
      var float[] normPoints = new ArrayList(points)
      toNorm.mapPoints(normPoints)
      new Stroke(normPoints)
    ]))
  }

  override protected onPause() {
    (application as MoonRunes).save // persist the new notes

    super.onPause()
  }

}
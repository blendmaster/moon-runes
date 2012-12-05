package moon.runes

import android.app.Activity
import com.googlecode.androidannotations.annotations.EActivity
import android.os.Bundle
import android.gesture.GestureOverlayView
import android.gesture.Gesture
import moon.runes.Note
import android.graphics.RectF
import android.graphics.Matrix
import static android.gesture.GestureOverlayView.*

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
    Note::notes += note

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
    note.runes += new Rune(gesture.strokes.map[path].map[
      it.transform(toNorm); it
    ])
  }

}
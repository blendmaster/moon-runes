package moon.runes

import android.app.Activity
import com.googlecode.androidannotations.annotations.EActivity
import android.os.Bundle
import android.gesture.GestureOverlayView
import static android.gesture.GestureOverlayView.*
import android.gesture.Gesture
import moon.runes.Note

/**
 * "I use the Pensieve. One simply siphons the excess thoughts from one's 
 * mind, pours them into the basin, and examines them at one's leisure. 
 * It becomes easier to spot patterns and links, you understand, when 
 * they are in this form." 
 */
@EActivity
class Recorder extends Activity 
implements GestureOverlayView$OnGesturePerformedListener {
  Note note

  override onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState)

    note = new Note

    val it = new GestureOverlayView(this)
    addOnGesturePerformedListener(this)

    // be really lenient in what strokes to accept
    gestureStrokeType               = GESTURE_STROKE_TYPE_MULTIPLE
    gestureStrokeAngleThreshold     = 1
    gestureStrokeSquarenessTreshold = 0

    this.contentView = it
  }

  override onGesturePerformed(GestureOverlayView view, Gesture gesture) {
    note.runes += new Rune(gesture.strokes.map[path])
  }

}
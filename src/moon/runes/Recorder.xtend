package moon.runes

import android.app.Activity
import com.googlecode.androidannotations.annotations.EActivity
import android.os.Bundle
import android.gesture.GestureOverlayView
import android.gesture.Gesture
import android.util.Log
import com.googlecode.androidannotations.annotations.Fullscreen
import com.googlecode.androidannotations.annotations.NoTitle

/**
 * "I use the Pensieve. One simply siphons the excess thoughts from one's 
 * mind, pours them into the basin, and examines them at one's leisure. 
 * It becomes easier to spot patterns and links, you understand, when 
 * they are in this form." 
 */
@EActivity @Fullscreen @NoTitle
class Recorder extends Activity 
implements GestureOverlayView$OnGesturePerformedListener {

  override onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState)

    val overlay = new GestureOverlayView(this)
    overlay.addOnGesturePerformedListener(this)

    contentView = overlay
  }

  override onGesturePerformed(GestureOverlayView view, Gesture gesture) {
    Log::d("recorder", "Gesture Performed!")
  }

}
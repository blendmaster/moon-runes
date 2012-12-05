package moon.runes

import android.view.View
import android.content.Context
import android.graphics.Canvas
import android.util.AttributeSet
import android.graphics.Paint
import android.graphics.Color
import android.graphics.Matrix

/**
 * "Stand by the grey stone when the thrush knocks and 
 *  the setting sun with the last light of Durin's Day will shine upon 
 *  the key-hole."
 * 
 * Draws the note's runes as "text", left-to-right order.
 */
class RuneView extends View {

  @Property Note note
  def setNote(Note note) {
    _note = note
    invalidate() // redraw at some point
  }

  new(Context ctx, AttributeSet attrs, int defStyle) {
    super(ctx, attrs, defStyle)
  }

  new(Context ctx, AttributeSet attrs) {
    super(ctx, attrs)
  }

  new(Context ctx) {
    super(ctx)
  }

  // in px
  // TODO invalidate on Set
  @Property var fontSize      = 100
  @Property var lineHeight    = 150
  @Property var letterSpacing = 110
  @Property var paddingLeft   = 10
  @Property var paddingTop    = 10

  // carriage position, as x offset
  var carriage = 0

  override onDraw(Canvas c) {
    if (note == null) return;

    val p = new Paint
    p.color       = Color::BLACK
    p.style       = Paint$Style::STROKE
    p.strokeWidth = 5

    val toLetter = new Matrix
    toLetter.setScale(fontSize, fontSize)
    toLetter.postTranslate(paddingLeft, paddingTop)

    carriage = 0

    // TODO transform and place each rune separately
    note.runes.forEach [
      it.paths.forEach [
        it.transform(toLetter)
        c.drawPath(it, p)
      ]

      toLetter.postTranslate(letterSpacing, 0)
      carriage = carriage + letterSpacing // XXX "+=" not allowed ;_;
      if ((carriage + letterSpacing) > width) {
        toLetter.postTranslate(-carriage, 0) // carriage return
        carriage = 0
        toLetter.postTranslate(0, lineHeight) // line feed
      }
    ]

  }

}
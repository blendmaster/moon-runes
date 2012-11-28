package moon.runes

import android.view.View
import android.content.Context
import android.graphics.Canvas
import android.util.AttributeSet
import android.graphics.Paint
import android.graphics.Color

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

  override onDraw(Canvas c) {
    if (note == null) return

    val p = new Paint
    p.color = Color::BLACK
    p.style = Paint$Style::STROKE

    // TODO transform and place each rune separately
    note.runes.forEach [
      it.paths.forEach [
        c.drawPath(it, p)
      ]
    ]

  }

}
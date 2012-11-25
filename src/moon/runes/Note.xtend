package moon.runes

import java.util.List
import java.util.Date
import android.content.Context
import java.util.ArrayList
import static android.text.format.DateUtils.*

/**
 * A piece of your memory.
 */
class Note {
  @Property List<Rune> runes = new ArrayList<Rune>
  @Property String annotation = ''

  @Property Date creationTime = new Date()

  def getRelativeCreationTime(Context c) {
    getRelativeDateTimeString(c,
                              creationTime.time,
                              MINUTE_IN_MILLIS,
                              WEEK_IN_MILLIS,
                              0)
  }

  override toString() {
    '''Note: «getRelativeTimeSpanString(creationTime.time,
                                        new Date().time,
                                        MINUTE_IN_MILLIS,
                                        0)»'''
  }
}
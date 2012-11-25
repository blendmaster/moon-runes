package moon.runes

import java.util.List
import java.util.Date
import android.text.format.DateUtils
import android.content.Context
import java.util.ArrayList

/**
 * A piece of your memory.
 */
class Note {
  @Property List<Rune> runes = new ArrayList<Rune>
  @Property String annotation = ''

  @Property Date creationTime = new Date()

  def getRelativeCreationTime(Context c) {
    DateUtils::getRelativeDateTimeString(c,
                                         creationTime.getTime(),
                                         DateUtils::MINUTE_IN_MILLIS,
                                         DateUtils::WEEK_IN_MILLIS,
                                         0)
  }
}
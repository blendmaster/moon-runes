package moon.runes;

import static android.text.format.DateUtils.MINUTE_IN_MILLIS;
import static android.text.format.DateUtils.WEEK_IN_MILLIS;
import static android.text.format.DateUtils.getRelativeDateTimeString;
import static android.text.format.DateUtils.getRelativeTimeSpanString;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;
import android.content.Context;

/**
 * A piece of your memory.
 */
@Data class Note {
  private List<Rune> runes = new ArrayList<Rune>();
  private String annotation = "";

  private Date creationTime = new Date();

  String getRelativeCreationTime(Context c) {
    return (String)getRelativeDateTimeString(c,
                                             creationTime.getTime(),
                                             MINUTE_IN_MILLIS,
                                             WEEK_IN_MILLIS,
                                             0);
  }

  @Override
  public String toString() {
    return "Note: " + getRelativeTimeSpanString(creationTime.getTime(),
                                                new Date().getTime(),
                                                MINUTE_IN_MILLIS,
                                                0);
  }

}

package moon.runes

import java.util.List
import android.graphics.Path
import java.util.ArrayList

/**
 * A symbol of great power.
 */
class Rune {
  @Property List<Path> paths = new ArrayList<Path>
  
  new(List<Path> paths) { 
    this.paths = paths
  }
}
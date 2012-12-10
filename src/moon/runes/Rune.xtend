package moon.runes

import java.util.List
import org.eclipse.xtend.lib.Property

/**
 * A symbol of great power.
 */
class Rune {
  @Property List<Stroke> strokes

  new(List<Stroke> strokes) {
    this.strokes = strokes
  }
}
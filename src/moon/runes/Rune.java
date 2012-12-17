package moon.runes;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

/**
 * A symbol of great power.
 */
@Data class Rune {
  private List<Stroke> strokes = new ArrayList<Stroke>();

  Rune(List<Stroke> strokes) {
    this.strokes = strokes;
  }
}

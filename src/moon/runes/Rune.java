package moon.runes;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NonNull;

/**
 * A symbol of great power.
 */
@Data @AllArgsConstructor(suppressConstructorProperties=true)
public class Rune {
  @NonNull private List<Stroke> strokes;
}
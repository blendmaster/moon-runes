package moon.runes

import android.os.Bundle
import android.support.v4.app.Fragment
import com.googlecode.androidannotations.annotations.EFragment
import com.googlecode.androidannotations.annotations.AfterViews
import com.googlecode.androidannotations.annotations.ViewById
import com.googlecode.androidannotations.annotations.FragmentArg

/**
 * A fragment representing a single Note detail screen. This fragment is either
 * contained in a {@link NoteListActivity} in two-pane mode (on tablets) or a
 * {@link NoteDetailActivity} on handsets.
 */
@EFragment(R$layout::fragment_note_detail)
public class NoteDetailFragment extends Fragment {
  Note note
  @FragmentArg public int id

  override onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState)

    // TODO load from database or whatever
    note = MoonRunes::notes.get(id)
  }

  @ViewById public RuneView rune_view

  @AfterViews def void loadNote() {
    rune_view.note = note
  }

}

package moon.runes

import android.os.Bundle
import android.support.v4.app.Fragment
import android.widget.TextView
import com.googlecode.androidannotations.annotations.EFragment
import com.googlecode.androidannotations.annotations.AfterViews
import com.googlecode.androidannotations.annotations.ViewById
import com.googlecode.androidannotations.annotations.FragmentArg
import android.util.Log

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
    note = Note::notes.get(id)
  }

  @ViewById public TextView note_detail
  @AfterViews def loadNote() {
    note_detail.text = '''Runes: «note.runes.size»'''
  }

}

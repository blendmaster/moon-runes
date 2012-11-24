package moon.runes

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView

/**
 * A fragment representing a single Note detail screen. This fragment is either
 * contained in a {@link NoteListActivity} in two-pane mode (on tablets) or a
 * {@link NoteDetailActivity} on handsets.
 */
public class NoteDetailFragment extends Fragment {
  /**
   * The fragment argument representing the item ID that this fragment
   * represents.
   */
  public static val ARG_ITEM_ID = "item_id"

  private Note note

  /**
   * Mandatory empty constructor for the fragment manager to instantiate the
   * fragment (e.g. upon screen orientation changes).
   */
  new() {}

  override onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState)

    if (getArguments().containsKey(ARG_ITEM_ID)) {
      // TODO load from database or whatever
      note = new Note()
    }
  }

  override onCreateView(LayoutInflater inflater, ViewGroup container,
                         Bundle savedInstanceState) {
    val View rootView =
        inflater.inflate(R$layout::fragment_note_detail, container, false)

    // Show the dummy content as text in a TextView.
    if (note != null) {
      (rootView.findViewById(R$id::note_detail) as TextView)
        .setText(note.getRelativeCreationTime(getActivity()))
    }

    return rootView
  }
}

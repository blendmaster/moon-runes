package moon.runes

import android.content.Intent
import android.os.Bundle
import android.support.v4.app.FragmentActivity

/**
 * An activity representing a list of Notes. This activity has different
 * presentations for handset and tablet-size devices. On handsets, the activity
 * presents a list of items, which when touched, lead to a
 * {@link NoteDetailActivity} representing item details. On tablets, the
 * activity presents the list of items and item details side-by-side using two
 * vertical panes.
 * <p>
 * The activity makes heavy use of fragments. The list of items is a
 * {@link NoteListFragment} and the item details (if present) is a
 * {@link NoteDetailFragment}.
 * <p>
 * This activity also implements the required {@link NoteListFragment.Callbacks}
 * interface to listen for item selections.
 */
public class NoteListActivity extends FragmentActivity
    implements Callbacks {

  /**
   * Whether or not the activity is in two-pane mode, i.e. running on a tablet
   * device.
   */
  private boolean mTwoPane

  override onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R$layout::activity_note_list)

    if (findViewById(R$id::note_detail_container) != null) {
      // The detail container view will be present only in the
      // large-screen layouts (res/values-large and
      // res/values-sw600dp). If this view is present, then the
      // activity should be in two-pane mode.
      mTwoPane = true

      // In two-pane mode, list items should be given the
      // 'activated' state when touched.
      (getSupportFragmentManager()
        .findFragmentById(R$id::note_list) as NoteListFragment)
        .setActivateOnItemClick(true);
    }
  }

  /**
   * Callback method from {@link NoteListFragment.Callbacks} indicating that the
   * item with the given ID was selected.
   */
  override onItemSelected(String theid) {
    // XXX stupid xtend breaks if there is an argument called "id" and 
    // a static access to a static inner class "R$id" due to its aggressive 
    // importing and caching of everything in the compiled output.
    if (mTwoPane) {
      // In two-pane mode, show the detail view in this activity by
      // adding or replacing the detail fragment using a
      // fragment transaction.
      val arguments = new Bundle()
      arguments.putString(NoteDetailFragment::ARG_ITEM_ID, theid)
      val fragment = new NoteDetailFragment()
      fragment.setArguments(arguments)
      getSupportFragmentManager().beginTransaction()
                                 .replace(R$id::note_detail_container, fragment)
                                 .commit()

    } else {
      // In single-pane mode, simply start the detail activity
      // for the selected item ID.
      val detailIntent = new Intent(this, typeof(NoteDetailActivity))
      detailIntent.putExtra(NoteDetailFragment::ARG_ITEM_ID, theid)
      startActivity(detailIntent)
    }
  }
}

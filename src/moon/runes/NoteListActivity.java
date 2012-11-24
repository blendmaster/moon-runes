package moon.runes;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;

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
    implements NoteListFragment.Callbacks {

  /**
   * Whether or not the activity is in two-pane mode, i.e. running on a tablet
   * device.
   */
  private boolean mTwoPane;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_note_list);

    if (findViewById(R.id.note_detail_container) != null) {
      // The detail container view will be present only in the
      // large-screen layouts (res/values-large and
      // res/values-sw600dp). If this view is present, then the
      // activity should be in two-pane mode.
      mTwoPane = true;

      // In two-pane mode, list items should be given the
      // 'activated' state when touched.
      ((NoteListFragment)getSupportFragmentManager()
        .findFragmentById(R.id.note_list))
        .setActivateOnItemClick(true);
    }
  }

  /**
   * Callback method from {@link NoteListFragment.Callbacks} indicating that the
   * item with the given ID was selected.
   */
  @Override
  public void onItemSelected(String id) {
    if (mTwoPane) {
      // In two-pane mode, show the detail view in this activity by
      // adding or replacing the detail fragment using a
      // fragment transaction.
      Bundle arguments = new Bundle();
      arguments.putString(NoteDetailFragment.ARG_ITEM_ID, id);
      NoteDetailFragment fragment = new NoteDetailFragment();
      fragment.setArguments(arguments);
      getSupportFragmentManager().beginTransaction()
                                 .replace(R.id.note_detail_container, fragment)
                                 .commit();

    } else {
      // In single-pane mode, simply start the detail activity
      // for the selected item ID.
      Intent detailIntent = new Intent(this, NoteDetailActivity.class);
      detailIntent.putExtra(NoteDetailFragment.ARG_ITEM_ID, id);
      startActivity(detailIntent);
    }
  }
}

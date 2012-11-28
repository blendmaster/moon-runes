package moon.runes

import android.app.Activity
import android.os.Bundle
import android.support.v4.app.ListFragment
import android.view.View
import android.widget.ArrayAdapter
import android.widget.ListView

import static moon.runes.NoteListFragment.*
import com.googlecode.androidannotations.annotations.EFragment

/**
 * A list fragment representing a list of Notes. This fragment also supports
 * tablet devices by allowing list items to be given an 'activated' state upon
 * selection. This helps indicate which item is currently being viewed in a
 * {@link NoteDetailFragment}.
 * <p>
 * Activities containing this fragment MUST implement the {@link Callbacks}
 * interface.
 */
@EFragment
public class NoteListFragment extends ListFragment {

  /**
   * The serialization (saved instance state) Bundle key representing the
   * activated item position. Only used on tablets.
   */
  private static val STATE_ACTIVATED_POSITION = "activated_position"

  /**
   * The fragment's current callback object, which is notified of list item
   * clicks.
   */
  private Callbacks mCallbacks = sDummyCallbacks

  /**
   * The current activated item position. Only used on tablets.
   */
  private int mActivatedPosition = ListView::INVALID_POSITION

  /**
   * A dummy implementation of the {@link Callbacks} interface that does
   * nothing. Used only when this fragment is not attached to an activity.
   */
  private static Callbacks sDummyCallbacks = {[]}

  override onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState)

    // TODO: replace with a real list adapter.
    listAdapter = new ArrayAdapter<Note>(
      activity,
      android::R$layout::simple_list_item_activated_1,
      android::R$id::text1,
      Note::notes)
  }

  override onViewCreated(View view, Bundle savedInstanceState) {
    super.onViewCreated(view, savedInstanceState)

    // Restore the previously serialized activated item position.
    if (savedInstanceState?.containsKey(STATE_ACTIVATED_POSITION)) {
      activatedPosition =
        savedInstanceState.getInt(STATE_ACTIVATED_POSITION)
    }
  }

  override onAttach(Activity activity) {
    super.onAttach(activity)

    // Activities containing this fragment must implement its callbacks.
    if (!(activity instanceof Callbacks)) {
      throw new IllegalStateException(
        "Activity must implement fragment's callbacks.")
    }

    mCallbacks = activity as Callbacks;
  }

  override onResume() {
    super.onResume()
    // refresh list of runes
    // TODO find better way to do this
    listAdapter = new ArrayAdapter<Note>(
      activity,
      android::R$layout::simple_list_item_activated_1,
      android::R$id::text1,
      Note::notes)
  }

  override onDetach() {
    super.onDetach()

    // Reset the active callbacks interface to the dummy implementation.
    mCallbacks = sDummyCallbacks
  }

  override onListItemClick(ListView listView,
                            View view,
                            int position,
                            long id) {
    super.onListItemClick(listView, view, position, id)

    // unsafe cast, oh well
    mCallbacks.onItemSelected(id as int)
  }

  override onSaveInstanceState(Bundle outState) {
    super.onSaveInstanceState(outState)
    if (mActivatedPosition != ListView::INVALID_POSITION) {
      // Serialize and persist the activated item position.
      outState.putInt(STATE_ACTIVATED_POSITION, mActivatedPosition)
    }
  }

  /**
   * Turns on activate-on-click mode. When this mode is on, list items will be
   * given the 'activated' state when touched.
   */
  def void setActivateOnItemClick(boolean activateOnItemClick) {
    // When setting CHOICE_MODE_SINGLE, ListView will automatically
    // give items the 'activated' state when touched.
    listView.choiceMode = if (activateOnItemClick)
        ListView::CHOICE_MODE_SINGLE
        else ListView::CHOICE_MODE_NONE
  }

  def private void setActivatedPosition(int position) {
    if (position == ListView::INVALID_POSITION) {
      listView.setItemChecked(mActivatedPosition, false)
    } else {
      listView.setItemChecked(position, true)
    }

    mActivatedPosition = position
  }
}

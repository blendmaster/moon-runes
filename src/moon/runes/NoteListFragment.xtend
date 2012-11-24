package moon.runes

import android.app.Activity
import android.os.Bundle
import android.support.v4.app.ListFragment
import android.view.View
import android.widget.ArrayAdapter
import android.widget.ListView
import java.util.ArrayList

import static moon.runes.NoteListFragment.*

/**
 * A list fragment representing a list of Notes. This fragment also supports
 * tablet devices by allowing list items to be given an 'activated' state upon
 * selection. This helps indicate which item is currently being viewed in a
 * {@link NoteDetailFragment}.
 * <p>
 * Activities containing this fragment MUST implement the {@link Callbacks}
 * interface.
 */
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

  /**
   * Mandatory empty constructor for the fragment manager to instantiate the
   * fragment (e.g. upon screen orientation changes).
   */
  new() {}

  override onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState)

    val notes = new ArrayList<Note>()
    notes.add(new Note())
    notes.add(new Note())
    notes.add(new Note())

    // TODO: replace with a real list adapter.
    setListAdapter(new ArrayAdapter<Note>(getActivity(),
                                          android::R$layout::simple_list_item_activated_1,
                                          android::R$id::text1,
                                          notes))
  }

  override onViewCreated(View view, Bundle savedInstanceState) {
    super.onViewCreated(view, savedInstanceState)

    // Restore the previously serialized activated item position.
    if (savedInstanceState != null
        && savedInstanceState.containsKey(STATE_ACTIVATED_POSITION)) {
      setActivatedPosition(savedInstanceState.getInt(STATE_ACTIVATED_POSITION))
    }
  }

  override onAttach(Activity activity) {
    super.onAttach(activity)

    // Activities containing this fragment must implement its callbacks.
    if (!(activity instanceof Callbacks)) {
      throw new IllegalStateException("Activity must implement fragment's callbacks.")
    }

    mCallbacks = activity as Callbacks;
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

    // Notify the active callbacks interface (the activity, if the
    // fragment is attached to one) that an item has been selected.
    // TODO
    mCallbacks.onItemSelected("1")
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
    getListView().setChoiceMode(if (activateOnItemClick)
        ListView::CHOICE_MODE_SINGLE
        else ListView::CHOICE_MODE_NONE)
  }

  def private void setActivatedPosition(int position) {
    if (position == ListView::INVALID_POSITION) {
      getListView().setItemChecked(mActivatedPosition, false)
    } else {
      getListView().setItemChecked(position, true)
    }

    mActivatedPosition = position
  }
}

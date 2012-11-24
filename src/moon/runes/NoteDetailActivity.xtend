package moon.runes

import android.content.Intent
import android.os.Bundle
import android.support.v4.app.FragmentActivity
import android.support.v4.app.NavUtils
import android.view.MenuItem

import com.googlecode.androidannotations.annotations.EActivity

/**
 * An activity representing a single Note detail screen. This activity is only
 * used on handset devices. On tablet-size devices, item details are presented
 * side-by-side with a list of items in a {@link NoteListActivity}.
 * <p>
 * This activity is mostly just a 'shell' activity containing nothing more than
 * a {@link NoteDetailFragment}.
 */
@EActivity(R$layout::activity_note_detail)
public class NoteDetailActivity extends FragmentActivity {

  override onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState)

    actionBar.displayHomeAsUpEnabled = true

    // add if fragment hasn't already been added
    if (savedInstanceState == null) {
      val arguments = new Bundle()
      arguments.putString("id", intent.getStringExtra("id"))
      val fragment = new NoteDetailFragment_()
      fragment.arguments = arguments
      supportFragmentManager.beginTransaction()
                            .add(R$id::note_detail_container, fragment)
                            .commit()
    }
  }

  override onOptionsItemSelected(MenuItem item) {
    switch item.itemId {
    case android::R$id::home: {
        NavUtils::navigateUpTo(this, 
                               new Intent(this, typeof(NoteListActivity_)))
        return true
      }
    }
    return super.onOptionsItemSelected(item)
  }
}

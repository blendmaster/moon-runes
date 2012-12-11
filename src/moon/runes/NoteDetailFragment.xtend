package moon.runes

import android.content.Intent
import android.graphics.Bitmap
import android.graphics.Bitmap$CompressFormat
import android.graphics.Bitmap$Config
import android.graphics.Canvas
import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.Menu
import android.view.MenuInflater
import android.widget.ShareActionProvider
import com.googlecode.androidannotations.annotations.AfterViews
import com.googlecode.androidannotations.annotations.EFragment
import com.googlecode.androidannotations.annotations.FragmentArg
import com.googlecode.androidannotations.annotations.ViewById
import java.io.ByteArrayOutputStream
import java.io.File
import android.content.Context
import java.io.IOException
import android.net.Uri
import java.io.FileOutputStream
import android.graphics.Color
import android.os.Environment
import android.util.Log
import java.io.ByteArrayInputStream
import android.provider.MediaStore

/**
 * A fragment representing a single Note detail screen. This fragment is either
 * contained in a {@link NoteListActivity} in two-pane mode (on tablets) or a
 * {@link NoteDetailActivity} on handsets.
 */
@EFragment(R$layout::fragment_note_detail)
public class NoteDetailFragment extends Fragment {
  Note note
  @FragmentArg public int theid

  override onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState)

    hasOptionsMenu = true

    // TODO load from database or whatever
    note = MoonRunes::notes.get(theid)
  }

  @ViewById public RuneView rune_view
  @AfterViews def void loadNote() {
    rune_view.note = note
  }
  
  override onResume() {
    super.onResume()
    
    
    Log::d("writer", "creating intent!")
    sap.shareIntent = {
      val it = new Intent
      action = Intent::ACTION_SEND
      putExtra(Intent::EXTRA_TEXT, "This is a note, yo!")
      putExtra(Intent::EXTRA_STREAM, createImage())
      type = "image/png"

      it
    }
    // force share intent to rerender
    // http://stackoverflow.com/questions/12087164/shareactionprovider-not-clickable-and-not-rendering-properly-on-first-render
    activity.invalidateOptionsMenu
  }

  ShareActionProvider sap

  override onCreateOptionsMenu(Menu m, MenuInflater inflater) {
    inflater.inflate(R$menu::note_detail_menu, m)

    sap = m.findItem(R$id::menu_item_share).actionProvider 
          as ShareActionProvider

    super.onCreateOptionsMenu(m, inflater)
  }

  // create a png drawable from the note
  def private createImage() {
    val img = Bitmap::createBitmap(700,
                                   700,
                                   Bitmap$Config::ARGB_8888)
    rune_view.draw(new Canvas(img))
  
    val f = new File(Environment::externalStorageDirectory + File::separator + "/note.png")
    Log::d("writer", ",aleomg jfile!")
    f.delete
    f.createNewFile
    img.compress(Bitmap$CompressFormat::PNG, 100, new FileOutputStream(f))
    Uri::fromFile(f)
  }

}

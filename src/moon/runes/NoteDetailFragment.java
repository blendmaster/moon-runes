package moon.runes;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import android.annotation.TargetApi;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.widget.ShareActionProvider;

import com.googlecode.androidannotations.annotations.AfterViews;
import com.googlecode.androidannotations.annotations.EFragment;
import com.googlecode.androidannotations.annotations.FragmentArg;
import com.googlecode.androidannotations.annotations.ViewById;

/**
 * A fragment representing a single Note detail screen. This fragment is either
 * contained in a {@link NoteListActivity} in two-pane mode (on tablets) or a
 * {@link NoteDetailActivity} on handsets.
 */
@TargetApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
@EFragment(R.layout.fragment_note_detail)
public class NoteDetailFragment extends Fragment {
  Note note;
  @FragmentArg
  public int id;

  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    setHasOptionsMenu(true);

    note = MoonRunes.notes.get(id);
  }

  @ViewById
  public RuneView rune_view;

  @AfterViews
  void loadNote() {
    rune_view.note = note;
  }

  @Override
  public void onResume() {
    super.onResume();

    Log.d("writer", "creating intent!");
    Intent it = new Intent();
    it.setAction(Intent.ACTION_SEND);
    it.putExtra(Intent.EXTRA_TEXT, "This is a note, yo!");
    it.putExtra(Intent.EXTRA_STREAM, createImage());
    it.setType("image/png");
    // force share intent to rerender
    // http://stackoverflow.com/questions/12087164/shareactionprovider-not-clickable-and-not-rendering-properly-on-first-render
    getActivity().invalidateOptionsMenu();
  }

  ShareActionProvider sap;

  @Override
  public void onCreateOptionsMenu(Menu m, MenuInflater inflater) {
    inflater.inflate(R.menu.note_detail_menu, m);

    sap =
        (ShareActionProvider)m.findItem(R.id.menu_item_share)
                              .getActionProvider();

    super.onCreateOptionsMenu(m, inflater);
  }

  // create a png drawable from the note
  private Uri createImage() {
    Bitmap img = Bitmap.createBitmap(700,
                                     700,
                                     Bitmap.Config.ARGB_8888);
    rune_view.draw(new Canvas(img));

    File f =
        new File(Environment.getExternalStorageDirectory() + File.separator
            + "/note.png");
    Log.d("writer", ",aleomg jfile!");
    f.delete();
    try {
      f.createNewFile();
    } catch (IOException e) {
      Log.e("writer", "oh fuck", e);
    }
    try {
      img.compress(Bitmap.CompressFormat.PNG, 100, new FileOutputStream(f));
    } catch (FileNotFoundException e) {
      Log.e("writer", "oh fuck", e);
    }
    return Uri.fromFile(f);
  }

}

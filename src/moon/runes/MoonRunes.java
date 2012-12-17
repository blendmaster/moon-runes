package moon.runes;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import android.app.Application;
import android.content.Context;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;

/**
 * JSON based persistence layer. fuck yeah
 */
class MoonRunes extends Application {

  static final String FILE = "notes.json";

  public static List<Note> notes;

  Gson gson;

  @Override
  public void onCreate() {
    super.onCreate();

    // read out the notes
    notes = new ArrayList<Note>();

    gson = new GsonBuilder().setVersion(1.0).create();
    try {
      JsonReader reader =
          new JsonReader(
                         new InputStreamReader(openFileInput(FILE), "UTF-8")
          );
      reader.beginArray();
      while (reader.hasNext()) {
        Note note = gson.fromJson(reader, Note.class);
        notes.add(note);
      }
      reader.endArray();
      reader.close();
    } catch (FileNotFoundException e) {
      // whatever dude
    } catch (UnsupportedEncodingException e) {
      // I really wish I had java 7 multiple catch
    } catch (IOException e) {
    }
  }

  void save() {
    JsonWriter writer;
    try {
      writer = new JsonWriter(
        new OutputStreamWriter(
          openFileOutput(FILE,Context.MODE_PRIVATE),"UTF-8"));
      writer.setIndent("  ");
      writer.beginArray();
      for (Note note : notes) {
        gson.toJson(note, Note.class, writer);
      }
      writer.endArray();
      writer.close();

    } catch (UnsupportedEncodingException e) {
    } catch (FileNotFoundException e) {
    } catch (IOException e) {}
  }

}

package moon.runes

import android.app.Application
import android.content.Context
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.stream.JsonReader
import com.google.gson.stream.JsonWriter
import java.io.FileNotFoundException
import java.io.InputStreamReader
import java.io.OutputStreamWriter
import java.util.ArrayList
import java.util.List

import static extension moon.runes.MoonRunes.*

/**
 * JSON based persistence layer. fuck yeah
 */
class MoonRunes extends Application {

  static val FILE = "notes.json"

  public static List<Note> notes

  Gson gson

  override onCreate() {
    super.onCreate()

    // read out the notes
    notes = new ArrayList<Note>
 
    gson = new GsonBuilder().setVersion(1.0).create
    try {
      val reader = new JsonReader(
        new InputStreamReader(openFileInput(FILE), "UTF-8")
      )
      reader.beginArray
      while (reader.hasNext) {
        val Note note = gson.fromJson(reader, typeof(Note))
        notes += note // XXX bad xtend type inference here
      }
      reader.endArray
      reader.close
    } catch (FileNotFoundException e) {
      // whatever dude
    }
  }

  def save() {
    val writer = new JsonWriter(
      new OutputStreamWriter(
        openFileOutput(FILE, Context::MODE_PRIVATE), "UTF-8"
      )
    )
    writer.indent = '  '
    writer.beginArray
    notes.forEach [ gson.toJson(it, typeof(Note), writer) ]
    writer.endArray
    writer.close
  }

}
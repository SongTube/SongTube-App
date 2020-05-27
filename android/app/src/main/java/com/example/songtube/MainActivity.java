package com.example.songtube;

import android.content.Intent;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;
import android.net.Uri;

import org.jaudiotagger.audio.AudioFile;
import org.jaudiotagger.audio.AudioFileIO;
import org.jaudiotagger.audio.exceptions.CannotReadException;
import org.jaudiotagger.audio.exceptions.CannotWriteException;
import org.jaudiotagger.audio.exceptions.InvalidAudioFrameException;
import org.jaudiotagger.audio.exceptions.ReadOnlyFileException;
import org.jaudiotagger.tag.FieldKey;
import org.jaudiotagger.tag.Tag;
import org.jaudiotagger.tag.TagException;
import org.jaudiotagger.tag.images.Artwork;
import org.jaudiotagger.tag.images.ArtworkFactory;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class MainActivity extends FlutterActivity {
  String sharedText;
  private static final String CHANNEL = "sharedTextChannel";
  private static final String CONVERTER_CHANNEL = "registerMedia";
  private static final String TAGS_CHANNEL = "tagsChannel";
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler(
          (call, result) -> {
            if (call.method.equals("getSharedText")) {
              result.success(sharedText);
            }
            if (call.method.equals("clearSharedText")) {
              sharedText = null;
              result.success(0);
            }
          }
        );
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CONVERTER_CHANNEL)
        .setMethodCallHandler(
          (call, result) -> {
            if (call.method.equals("registerFile")) {
              String argument = call.argument("file");
              File file = new File(argument);
              sendBroadcast(new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.fromFile(file)));
            }
          }
        );
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), TAGS_CHANNEL)
            .setMethodCallHandler(
                    (call, result) -> {
                        if (call.method.equals("writeAllTags")) {
                            String songPath   = call.argument("songPath"  );
                            String tagsTitle  = call.argument("tagsTitle" );
                            String tagsAlbum  = call.argument("tagsAlbum" );
                            String tagsArtist = call.argument("tagsArtist");
                            String tagsGenre  = call.argument("tagsGenre" );
                            String tagsYear   = call.argument("tagsYear"  );
                            String tagsDisc   = call.argument("tagsDisc"  );
                            String tagsTrack  = call.argument("tagsTrack" );
                            int response = TagsMethods.writeAllTags(
                              songPath,
                              tagsTitle,
                              tagsAlbum,
                              tagsArtist,
                              tagsGenre,
                              tagsYear,
                              tagsDisc,
                              tagsTrack
                            );
                            result.success(response);
                        }
                        if (call.method.equals("writeArtwork")) {
                            String songPath    = call.argument("songPath");
                            String artworkPath = call.argument("artworkPath");
                            int response = TagsMethods.writeArtwork(songPath, artworkPath);
                            result.success(response);
                        }
                        if (call.method.equals("writeTag")) {
                            FieldKey fieldKey = null;
                            String songPath  = call.argument("songPath" );
                            String tagKey    = call.argument("tagKey"   );
                            String tagString = call.argument("tagString");
                            assert tagKey != null;
                            if (tagKey.equals("title") ) {fieldKey = FieldKey.TITLE;  }
                            if (tagKey.equals("album") ) {fieldKey = FieldKey.ALBUM;  }
                            if (tagKey.equals("artist")) {fieldKey = FieldKey.ARTIST; }
                            if (tagKey.equals("genre") ) {fieldKey = FieldKey.GENRE;  }
                            if (tagKey.equals("year")  ) {fieldKey = FieldKey.YEAR;   }
                            if (tagKey.equals("disc")  ) {fieldKey = FieldKey.DISC_NO;}
                            if (tagKey.equals("track") ) {fieldKey = FieldKey.TRACK;  }
                            int response = TagsMethods.writeTag(songPath, fieldKey, tagString);
                            result.success(response);
                        }
                    }
            );
  }

  @Override
  protected void onNewIntent(Intent intent) {
    super.onNewIntent(intent);
    setIntent(intent);
    intent = getIntent();
    String action = intent.getAction();
    String type = intent.getType();
    if (Intent.ACTION_SEND.equals(action) && type != null) {
      if ("text/plain".equals(type)) {
        sharedText = intent.getStringExtra(Intent.EXTRA_TEXT);
      }
    }
  }

}

class TagsMethods {

    // ------------------------------
    // Functions library to write any
    // song metadata and artwork
    // ------------------------------

    // Write all tags at once into an AudioFile
    static int writeAllTags(
      String songPath,
      String title,
      String album,
      String artist,
      String genre,
      String year,
      String disc,
      String track
    ) {
        File file = new File(songPath);
        try {
            AudioFile audioFile = AudioFileIO.read(file);
            Tag tag = audioFile.getTagOrCreateAndSetDefault();
            if (title  != null) tag.setField(FieldKey.TITLE, title);
            if (album  != null) tag.setField(FieldKey.ALBUM, album);
            if (artist != null) tag.setField(FieldKey.ARTIST, artist);
            if (genre  != null) tag.setField(FieldKey.GENRE, genre);
            if (year   != null) tag.setField(FieldKey.YEAR, year);
            if (disc   != null) tag.setField(FieldKey.DISC_NO, disc);
            if (track  != null) tag.setField(FieldKey.TRACK, track);
            audioFile.commit();
            return 0;
        } catch (@NonNull CannotReadException | IOException | CannotWriteException | TagException | ReadOnlyFileException | InvalidAudioFrameException e) {
            e.printStackTrace();
            return 1;
        }
    }

    // Write Artwork into an AudioFile
    static int writeArtwork(String songPath, String artworkPath) {
        File file = new File(songPath);
        File artworkFile = new File(artworkPath);
        try {
            AudioFile audioFile = AudioFileIO.read(file);
            Tag tag = audioFile.getTagOrCreateAndSetDefault();
            Artwork artwork = ArtworkFactory.createArtworkFromFile(artworkFile);
            tag.setField(artwork);
            audioFile.commit();
            return 0;
        } catch (@NonNull CannotReadException | IOException | CannotWriteException | TagException | ReadOnlyFileException | InvalidAudioFrameException e) {
            e.printStackTrace();
            return 1;
        }
    }

    // Write individuals Tag
    static int writeTag(String songPath, FieldKey tagKey, String string) {
      if (string == null || tagKey == null) {return 1;}
      File file = new File(songPath);
      try {
        AudioFile audioFile = AudioFileIO.read(file);
        Tag tag = audioFile.getTagOrCreateAndSetDefault();
        tag.setField(tagKey, string);
        audioFile.commit();
        return 0;
      } catch (Exception e) {
        e.printStackTrace();
        return 1;
      }
    }
}

package com.example.songtube

import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.jaudiotagger.audio.AudioFileIO
import org.jaudiotagger.audio.exceptions.CannotReadException
import org.jaudiotagger.audio.exceptions.CannotWriteException
import org.jaudiotagger.audio.exceptions.InvalidAudioFrameException
import org.jaudiotagger.audio.exceptions.ReadOnlyFileException
import org.jaudiotagger.tag.FieldKey
import org.jaudiotagger.tag.TagException
import org.jaudiotagger.tag.images.ArtworkFactory
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileOutputStream
import java.io.IOException

class MainActivity : FlutterActivity() {
    private var sharedText: String? = null
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                    if (call.method == "getSharedText") {
                        result.success(sharedText)
                    }
                    if (call.method == "clearSharedText") {
                        sharedText = null
                        result.success(0)
                    }
                }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, IMAGE_CHANNEL)
                .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                    if (call.method == "cropToSquare") {
                        val argument = call.argument<String>("imagePath")
                        val bitmap = BitmapFactory.decodeFile(argument)
                        val croppedBitmap = cropToSquare(bitmap)
                        val bytes = ByteArrayOutputStream()
                        croppedBitmap?.compress(Bitmap.CompressFormat.PNG, 0, bytes)
                        val bitmapData = bytes.toByteArray()
                        val fos = FileOutputStream(File("$argument.png"))
                        fos.write(bitmapData)
                        fos.flush()
                        fos.close()
                        result.success("$argument.png")
                    }
                }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CONVERTER_CHANNEL)
                .setMethodCallHandler { call: MethodCall, _: MethodChannel.Result? ->
                    if (call.method == "registerFile") {
                        val argument = call.argument<String>("file")
                        val file = File(argument)
                        sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.fromFile(file)))
                    }
                }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, INTENT_CHANNEL)
                .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                    if (call.method == "openVideo") {
                        val videoPath = call.argument<String>("videoPath")
                        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(videoPath))
                        intent.setDataAndType(Uri.parse(videoPath), "video/*")
                        startActivity(intent)
                        result.success(0)
                    }
                    if (call.method == "requestAllFilesPermission") {
                        startActivityForResult(Intent(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION), 1)
                    }
                }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, TAGS_CHANNEL)
                .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                    if (call.method == "writeAllTags") {
                        val songPath = call.argument<String>("songPath")
                        val tagsTitle = call.argument<String>("tagsTitle")
                        val tagsAlbum = call.argument<String>("tagsAlbum")
                        val tagsArtist = call.argument<String>("tagsArtist")
                        val tagsGenre = call.argument<String>("tagsGenre")
                        val tagsYear = call.argument<String>("tagsYear")
                        val tagsDisc = call.argument<String>("tagsDisc")
                        val tagsTrack = call.argument<String>("tagsTrack")
                        val response = TagsMethods.writeAllTags(
                                songPath,
                                tagsTitle,
                                tagsAlbum,
                                tagsArtist,
                                tagsGenre,
                                tagsYear,
                                tagsDisc,
                                tagsTrack
                        )
                        result.success(response)
                    }
                    if (call.method == "writeArtwork") {
                        val songPath = call.argument<String>("songPath")
                        val artworkPath = call.argument<String>("artworkPath")
                        val response = TagsMethods.writeArtwork(songPath, artworkPath)
                        result.success(response)
                    }
                    if (call.method == "writeTag") {
                        var fieldKey: FieldKey? = null
                        val songPath = call.argument<String>("songPath")
                        val tagKey = call.argument<String>("tagKey")
                        val tagString = call.argument<String>("tagString")
                        if (BuildConfig.DEBUG && tagKey == null) {
                            error("Assertion failed")
                        }
                        if (tagKey == "title") {
                            fieldKey = FieldKey.TITLE
                        }
                        if (tagKey == "album") {
                            fieldKey = FieldKey.ALBUM
                        }
                        if (tagKey == "artist") {
                            fieldKey = FieldKey.ARTIST
                        }
                        if (tagKey == "genre") {
                            fieldKey = FieldKey.GENRE
                        }
                        if (tagKey == "year") {
                            fieldKey = FieldKey.YEAR
                        }
                        if (tagKey == "disc") {
                            fieldKey = FieldKey.DISC_NO
                        }
                        if (tagKey == "track") {
                            fieldKey = FieldKey.TRACK
                        }
                        val response = TagsMethods.writeTag(songPath, fieldKey, tagString)
                        result.success(response)
                    }
                }
    }

    override fun onNewIntent(intent: Intent) {
        var newIntent = intent
        super.onNewIntent(newIntent)
        setIntent(newIntent)
        newIntent = getIntent()
        val action = newIntent.action
        val type = newIntent.type
        if (Intent.ACTION_SEND == action && type != null) {
            if ("text/plain" == type) {
                sharedText = newIntent.getStringExtra(Intent.EXTRA_TEXT)
            }
        }
    }

    companion object {
        private const val CHANNEL = "sharedTextChannel"
        private const val CONVERTER_CHANNEL = "registerMedia"
        private const val TAGS_CHANNEL = "tagsChannel"
        private const val INTENT_CHANNEL = "intentChannel"
        private const val IMAGE_CHANNEL = "imageProcessing"
    }

    private fun cropToSquare(bitmap: Bitmap): Bitmap? {
        val width: Int = bitmap.width
        val height: Int = bitmap.height
        val newWidth = if (height > width) width else height
        val newHeight = if (height > width) height - (height - width) else height
        var cropW = (width - height) / 2
        cropW = if (cropW < 0) 0 else cropW
        var cropH = (height - width) / 2
        cropH = if (cropH < 0) 0 else cropH
        return Bitmap.createBitmap(bitmap, cropW, cropH, newWidth, newHeight)
    }
}

internal object TagsMethods {
    // ------------------------------
    // Functions library to write any
    // song metadata and artwork
    // ------------------------------
    // Write all tags at once into an AudioFile
    fun writeAllTags(
            songPath: String?,
            title: String?,
            album: String?,
            artist: String?,
            genre: String?,
            year: String?,
            disc: String?,
            track: String?
    ): Int {
        val file = File(songPath)
        return try {
            val audioFile = AudioFileIO.read(file)
            val tag = audioFile.tagOrCreateAndSetDefault
            if (title != null) tag.setField(FieldKey.TITLE, title)
            if (album != null) tag.setField(FieldKey.ALBUM, album)
            if (artist != null) tag.setField(FieldKey.ARTIST, artist)
            if (genre != null) tag.setField(FieldKey.GENRE, genre)
            if (year != null) tag.setField(FieldKey.YEAR, year)
            if (disc != null) tag.setField(FieldKey.DISC_NO, disc)
            if (track != null) tag.setField(FieldKey.TRACK, track)
            audioFile.commit()
            0
        } catch (e: CannotReadException) {
            e.printStackTrace()
            1
        } catch (e: IOException) {
            e.printStackTrace()
            1
        } catch (e: CannotWriteException) {
            e.printStackTrace()
            1
        } catch (e: TagException) {
            e.printStackTrace()
            1
        } catch (e: ReadOnlyFileException) {
            e.printStackTrace()
            1
        } catch (e: InvalidAudioFrameException) {
            e.printStackTrace()
            1
        }
    }

    // Write Artwork into an AudioFile
    fun writeArtwork(songPath: String?, artworkPath: String?): Int {
        val file = File(songPath)
        val artworkFile = File(artworkPath)
        return try {
            val audioFile = AudioFileIO.read(file)
            val tag = audioFile.tagOrCreateAndSetDefault
            val artwork = ArtworkFactory.createArtworkFromFile(artworkFile)
            tag.setField(artwork)
            audioFile.commit()
            0
        } catch (e: CannotReadException) {
            e.printStackTrace()
            1
        } catch (e: IOException) {
            e.printStackTrace()
            1
        } catch (e: CannotWriteException) {
            e.printStackTrace()
            1
        } catch (e: TagException) {
            e.printStackTrace()
            1
        } catch (e: ReadOnlyFileException) {
            e.printStackTrace()
            1
        } catch (e: InvalidAudioFrameException) {
            e.printStackTrace()
            1
        }
    }

    // Write individuals Tag
    fun writeTag(songPath: String?, tagKey: FieldKey?, string: String?): Int {
        if (string == null || tagKey == null) {
            return 1
        }
        val file = File(songPath)
        return try {
            val audioFile = AudioFileIO.read(file)
            val tag = audioFile.tagOrCreateAndSetDefault
            tag.setField(tagKey, string)
            audioFile.commit()
            0
        } catch (e: Exception) {
            e.printStackTrace()
            1
        }
    }
}
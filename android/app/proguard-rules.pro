-keep class org.schabi.newpipe.extractor.** { *; }
-keep class org.ocpsoft.prettytime.i18n.** { *; }

-keep class org.mozilla.javascript.** { *; }

-keep class org.mozilla.classfile.ClassFileWriter
# media3 (androidx.media3) ships its own consumer proguard rules; the old
# com.google.android.exoplayer2 keep is dead now that the video_player fork
# has been ported off ExoPlayer2.

-dontwarn org.mozilla.javascript.tools.**
-dontwarn android.arch.util.paging.CountedDataSource
-dontwarn android.arch.persistence.room.paging.LimitOffsetDataSource
-keep class com.artxdev.** { *; }
-keep class androidx.lifecycle.** { *; }
-keep class org.jaudiotagger.** { *; }
-keep class com.example.audio_tagger.** { *; }
-keep class com.arthenica.flutter.** { *; }
-dontobfuscate

## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# -keep class com.google.firebase.** { *; } // uncomment this if you are using firebase in the project

# ffmpeg_kit_flutter_new_audio ships its own consumer-rules.pro covering
# com.arthenica.ffmpegkit.**, so no manual keep rules are needed here. The old
# com.arthenica.mobileffmpeg.* rules were for the retired ffmpeg-kit package and
# referenced classes that no longer exist.

# Flutter references Play Core's deferred-component APIs, but this app does not
# bundle Play Core. Under AGP 8 / R8 those missing references are errors rather
# than warnings, which fails minifyReleaseWithR8.
-dontwarn com.google.android.play.core.**

# Rules for OkHttp. Copy paste from https://github.com/square/okhttp
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
# A resource is loaded with a relative path so the package of this class must be preserved.
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
}
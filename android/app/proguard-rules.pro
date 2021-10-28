-keep class org.schabi.newpipe.extractor.** { *; }
-keep class org.ocpsoft.prettytime.i18n.** { *; }

-keep class org.mozilla.javascript.** { *; }

-keep class org.mozilla.classfile.ClassFileWriter
-keep class com.google.android.exoplayer2.** { *; }

-dontwarn org.mozilla.javascript.tools.**
-dontwarn android.arch.util.paging.CountedDataSource
-dontwarn android.arch.persistence.room.paging.LimitOffsetDataSource
-keep class com.artxdev.** { *; }
-keep class androidx.lifecycle.** { *; }
-keep class org.jaudiotagger.** { *; }
-keep class com.example.audio_tagger.** { *; }
-dontobfuscate

## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# -keep class com.google.firebase.** { *; } // uncomment this if you are using firebase in the project

-keep class com.arthenica.mobileffmpeg.Config {
    native <methods>;
    void log(long, int, byte[]);
    void statistics(long, int, float, float, long , int, double, double);
}

-keep class com.arthenica.mobileffmpeg.AbiDetect {
    native <methods>;
}

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
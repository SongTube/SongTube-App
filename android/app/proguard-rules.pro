-keep class com.arthenica.mobileffmpeg.** { *; }
-keep class androidx.lifecycle.** { *; }
-keep class org.schabi.newpipe.** { *; }
-keep public class org.mozilla.** { *; }
-keep class com.artxdev.newpipeextractor_dart.** { *; }
## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
# -keep class com.google.firebase.** { *; } // uncomment this if you are using firebase in the project
-dontwarn io.flutter.embedding.**
-ignorewarnings
package com.artxdev.songtube

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
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import android.view.WindowManager
import android.os.Build
import androidx.core.view.WindowCompat
import android.view.Window;
import android.view.WindowInsetsController
import android.view.View
import android.graphics.Color

class MainActivity : FlutterActivity() {
    private var sharedText: String? = null
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            WindowCompat.setDecorFitsSystemWindows(window, false)
        }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                    if (call.method == "getSharedText") {
                        result.success(sharedText)
                    }
                    if (call.method == "clearSharedText") {
                        sharedText = null
                        result.success(0)
                    }
                    if (call.method == "exitFullScreen") {
                        window.clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
                        result.success(0)
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

    @Suppress("DEPRECATION")
    fun Window.setStatusBarDarkIcons(dark: Boolean) {
        when {
            Build.VERSION_CODES.R <= Build.VERSION.SDK_INT -> insetsController?.setSystemBarsAppearance(
                if (dark) WindowInsetsController.APPEARANCE_LIGHT_STATUS_BARS else 0,
                WindowInsetsController.APPEARANCE_LIGHT_STATUS_BARS
            )
            Build.VERSION_CODES.M <= Build.VERSION.SDK_INT -> decorView.systemUiVisibility = if (dark) {
                decorView.systemUiVisibility or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
            } else {
                decorView.systemUiVisibility and View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR.inv()
            }
            else -> if (dark) {
                // dark status bar icons not supported on API level below 23, set status bar
                // color to black to keep icons visible
                statusBarColor = Color.BLACK
            }
        }
    }

    @Suppress("DEPRECATION")
    fun Window.setNavigationBarDarkIcons(dark: Boolean) {
        when {
            Build.VERSION_CODES.R <= Build.VERSION.SDK_INT -> insetsController?.setSystemBarsAppearance(
                if (dark) WindowInsetsController.APPEARANCE_LIGHT_NAVIGATION_BARS else 0,
                WindowInsetsController.APPEARANCE_LIGHT_NAVIGATION_BARS
            )
            Build.VERSION_CODES.O <= Build.VERSION.SDK_INT -> decorView.systemUiVisibility = if (dark) {
                    decorView.systemUiVisibility or View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR
                } else {
                    decorView.systemUiVisibility and View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR.inv()
                }
            else -> if (dark) {
                // dark navigation bar icons not supported on API level below 26, set navigation bar
                // color to black to keep icons visible
                navigationBarColor = Color.BLACK
            }
        }
    }
}
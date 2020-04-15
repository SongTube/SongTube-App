package com.example.songtube;

import android.content.Intent;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import android.content.Context;
import android.net.Uri;
import java.io.File;

public class MainActivity extends FlutterActivity {
  String sharedText;
  private static final String CHANNEL = "sharedTextChannel";
  private static final String CONVERTERCHANNEL = "registerMedia";
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler(
          (call, result) -> {
            if (call.method.equals("getSharedText")) {
              result.success(sharedText);
            }
          }
        );
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CONVERTERCHANNEL)
        .setMethodCallHandler(
          (call, result) -> {
            if (call.method.equals("registerFile")) {
              String argument = call.argument("file");
              File file = new File(argument);
              sendBroadcast(new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.fromFile(file)));
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

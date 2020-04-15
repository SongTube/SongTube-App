import 'package:flutter/services.dart';
import 'songtube_classes.dart';

NativeMethod method;

class NativeMethod {

  static const media = const MethodChannel("registerMedia");
  static const platform = const MethodChannel("sharedTextChannel");
  String _sharedIntent;

  handleIntent() async {
    print("IntentHandler: Getting intent info...");
    String intent = await platform.invokeMethod('getSharedText');
    print("IntentHandler: Got intent: " + intent.toString());
    if (intent == null) return;
    if (intent == _sharedIntent) return;
    if (intent != _sharedIntent) {
      _sharedIntent = intent;
      appdata.unloadStreams();
      await downloader.getInfo(intent);
      appdata.progressController.add(0.0);
    }
  }

  void registerFile(String file) async {
    await media.invokeMethod('registerFile', {"file":file});
  }

}
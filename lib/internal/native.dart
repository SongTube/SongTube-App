import 'package:flutter/services.dart';
import 'songtube_classes.dart';

NativeMethod method;

class NativeMethod {

  static const media = const MethodChannel("registerMedia");
  static const platform = const MethodChannel("sharedTextChannel");

  Future<String> handleIntent() async {
    String _intent = await platform.invokeMethod('getSharedText');
    await platform.invokeMethod('clearSharedText');
    if (_intent == null) return null;
    print("IntentHandler: Result: " + _intent);
    return _intent;
  }

  void registerFile(String file) async {
    await media.invokeMethod('registerFile', {"file":file});
  }

}
 
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ccavenue_india_sdk_flutter_platform_interface.dart';

/// An implementation of [CcavenueIndiaSdkPlatform] that uses method channels.
class MethodChannelCcavenueIndiaSdk extends CcavenueIndiaSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('plugin_ccavenue'); // Matches your Kotlin CHANNEL

 @override
Future<String?> payCCAvenue(Map<String, dynamic> data) async {
  try {
    // This will receive whatever string Kotlin sends via result.success()
    final String? rawResponse = await methodChannel.invokeMethod<String>('payCCAvenue', data);
    return rawResponse;
  } on PlatformException catch (e) {
    return "Error: ${e.message}";
  }
}
}
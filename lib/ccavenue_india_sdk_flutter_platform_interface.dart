import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'ccavenue_india_sdk_flutter_method_channel.dart';

abstract class CcavenueIndiaSdkPlatform extends PlatformInterface {
  /// Constructs a CcavenueIndiaSdkPlatform.
  CcavenueIndiaSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static CcavenueIndiaSdkPlatform _instance = MethodChannelCcavenueIndiaSdk();

  /// The default instance of [CcavenueIndiaSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelCcavenueIndiaSdk].
  static CcavenueIndiaSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CcavenueIndiaSdkPlatform] when
  /// they register themselves.
  static set instance(CcavenueIndiaSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> payCCAvenue(Map<String, dynamic> data) {
    throw UnimplementedError('payCCAvenue() has not been implemented.');
  }
}
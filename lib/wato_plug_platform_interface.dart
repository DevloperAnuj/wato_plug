import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wato_plug_method_channel.dart';

abstract class WatoPlugPlatform extends PlatformInterface {
  /// Constructs a WatoPlugPlatform.
  WatoPlugPlatform() : super(token: _token);

  static final Object _token = Object();

  static WatoPlugPlatform _instance = MethodChannelWatoPlug();

  /// The default instance of [WatoPlugPlatform] to use.
  ///
  /// Defaults to [MethodChannelWatoPlug].
  static WatoPlugPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WatoPlugPlatform] when
  /// they register themselves.
  static set instance(WatoPlugPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

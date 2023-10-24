import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wato_plug_platform_interface.dart';

/// An implementation of [WatoPlugPlatform] that uses method channels.
class MethodChannelWatoPlug extends WatoPlugPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wato_plug');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

}

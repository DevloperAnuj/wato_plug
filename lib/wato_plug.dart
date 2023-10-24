import 'package:flutter/services.dart';
import 'wato_plug_platform_interface.dart';
import 'package:logger/logger.dart';

final Logger devLog = Logger();

class WatoPlug {

  static const _waMethodChannel = MethodChannel("wato_plug");

  static Future<void> messageToWhatsApp({
    required String number,
    required int package,
    String? message,
    String? link,
  }) async {
    Map<String, dynamic> parameters = {
      "phone": number,
      "message": message ?? "Hello from Wato!",
      "link": link ?? "",
      "package": package,
    };
    try {
      final result =
          await _waMethodChannel.invokeMethod("message_to", parameters);
      devLog.d(result);
    } catch (e) {
      devLog.e(e);
    }
  }

  static Future<void> filesToWhatsApp({
    required String number,
    required int package,
    required List<String> files,
  }) async {
    Map<String, dynamic> parameters = {
      "phone": number,
      "files": files,
      "package": package,
    };
    try {
      final result = await _waMethodChannel.invokeMethod("files_to", parameters);
      devLog.d(result);
    } catch (e) {
      devLog.e(e);
    }
  }

  static Future<bool> isWhatsAppBusinessInstalled() async {
    try {
      final result = await _waMethodChannel.invokeMethod("is_installed");
      if (result) {
        devLog.d("WhatsApp Business Installed");
      }
      return result;
    } catch (e) {
      devLog.e(e);
      rethrow;
    }
  }

  static Future<String?> getPlatformVersion() {
    return WatoPlugPlatform.instance.getPlatformVersion();
  }
}

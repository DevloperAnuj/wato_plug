import 'package:flutter_test/flutter_test.dart';
import 'package:wato_plug/wato_plug.dart';
import 'package:wato_plug/wato_plug_platform_interface.dart';
import 'package:wato_plug/wato_plug_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWatoPlugPlatform
    with MockPlatformInterfaceMixin
    implements WatoPlugPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WatoPlugPlatform initialPlatform = WatoPlugPlatform.instance;

  test('$MethodChannelWatoPlug is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWatoPlug>());
  });

  test('getPlatformVersion', () async {
    // WatoPlug watoPlugPlugin = WatoPlug();
    // MockWatoPlugPlatform fakePlatform = MockWatoPlugPlatform();
    // WatoPlugPlatform.instance = fakePlatform;
    //
    // expect(await watoPlugPlugin.getPlatformVersion(), '42');
  });
}

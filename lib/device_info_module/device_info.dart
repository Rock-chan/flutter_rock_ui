import 'dart:io';

import 'package:flutter_rock_ui/device_info_module/android_device_info.dart';
import 'package:flutter_rock_ui/device_info_module/device_info_strategy.dart';
import 'package:flutter_rock_ui/device_info_module/ios_device_info.dart';

class DeviceInfo {
  DeviceInfoStrategy? _strategy;

  DeviceInfo();

  Future<DeviceInfoStrategy?> getPlatform() async {
    if (Platform.isIOS) {
      _strategy = IosDeviceInformation();
      await _strategy?.getDeviceInfoPlugin();
    } else if (Platform.isAndroid) {
      _strategy = AndroidDeviceInformation();
      await _strategy?.getDeviceInfoPlugin();
    }
    return _strategy;
  }
}

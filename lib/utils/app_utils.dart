import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

/// 获取android版本
Future<double> getAndroidVersion() async {
  var androidInfo = await DeviceInfoPlugin().androidInfo;
  var release = double.parse(androidInfo.version.release);
  return release;
}

/// 获取ios版本
Future<double> getIosVersion() async {
  var iosInfo = await DeviceInfoPlugin().iosInfo;
  var release = double.parse(iosInfo.systemVersion ?? '0');
  return release;
}

/// 隐藏键盘
hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

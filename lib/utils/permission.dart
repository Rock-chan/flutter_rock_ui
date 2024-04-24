import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rock_ui/extensions/app_extensions.dart';
import 'package:flutter_rock_ui/utils/app_utils.dart';
import 'package:permission_handler/permission_handler.dart';

/// 检查是否有存储权限
Future<bool> checkStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
    if (!status.isGranted) {
      return false;
    }
  }
  return true;
}

/// 检查是否有相机权限
Future<bool> checkCameraPermission() async {
  if (Platform.isIOS) {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(onPressed: () {}, child: const Text("Cancel")),
          CupertinoActionSheetAction(onPressed: () {}, child: const Text("Confirm")),
        ],
      );
      '请在应用设置中打开相册权限'.toast();
      // AppSettings.openAppSettings(type: AppSettingsType.notification);
      return false;
    } else {
      return false;
    }
  } else if (Platform.isAndroid) {
    var version = await getAndroidVersion();
    Permission permission;

    if (version >= 33) {
      permission = Permission.photos;
    } else {
      permission = Permission.storage;
    }

    var status = await permission.status;
    if (!status.isGranted) {
      status = await permission.request();
    }

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      '请在应用设置中打开相册权限'.toast();
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      return false;
    } else {
      return false;
    }
  }
  return true;
}

/// 检查是否有录音权限
Future<bool> checkSpeechPermission() async {
  var status = await Permission.speech.status;
  if (Platform.isAndroid) {
    if (!status.isGranted) {
      status = await Permission.speech.request();
      if (!status.isGranted) {
        return false;
      }
    }
    return true;
  } else {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
      if (!status.isGranted) {
        return false;
      }
    }
    return true;
  }
}

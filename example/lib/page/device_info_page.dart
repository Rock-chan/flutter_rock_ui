import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/device_info_module/device_info.dart';
import 'package:flutter_rock_ui/device_info_module/device_info_strategy.dart';
import 'package:get/get.dart';

class DeviceInfoPage extends StatefulWidget {
  const DeviceInfoPage({super.key});

  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  DeviceInfo deviceInfo = DeviceInfo();

  DeviceInfoStrategy? strategy;

  @override
  void initState() {
    getDevicePlatform();
    super.initState();
  }

  getDevicePlatform() async {
    strategy = await deviceInfo.getPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Info Demo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('version.securityPatch: ${strategy?.getVersionSecurityPatch()}').marginOnly(top: 10.0),
            Text('version.sdkInt: ${strategy?.getVersionSdk()}').marginOnly(top: 10.0),
            Text('version.release:: ${strategy?.getVersionRelease()}').marginOnly(top: 10.0),
            Text('version.previewSdkInt: ${strategy?.getVersionPreviewSdk()}').marginOnly(top: 10.0),
            Text('version.incremental: ${strategy?.getVersionIncremental()}').marginOnly(top: 10.0),
            Text('version.codename: ${strategy?.getVersionCodename()}').marginOnly(top: 10.0),
            Text('version.baseOS: ${strategy?.getVersionBaseOS()}').marginOnly(top: 10.0),
            Text('board: ${strategy?.getBoard()}').marginOnly(top: 10.0),
            Text('bootloader: ${strategy?.getBootloader()}').marginOnly(top: 10.0),
            Text('brand: ${strategy?.getBrand()}').marginOnly(top: 10.0),
            Text('device: ${strategy?.getDevice()}').marginOnly(top: 10.0),
            Text('display: ${strategy?.getDisplay()}').marginOnly(top: 10.0),
            Text('fingerprint: ${strategy?.getFingerprint()}').marginOnly(top: 10.0),
            Text('hardware: ${strategy?.getHardware()}').marginOnly(top: 10.0),
            Text('host: ${strategy?.getHost()}').marginOnly(top: 10.0),
            Text('id: ${strategy?.getId()}').marginOnly(top: 10.0),
            Text('manufacturer: ${strategy?.getManufacturer()}').marginOnly(top: 10.0),
            Text('model: ${strategy?.getModel()}').marginOnly(top: 10.0),
            Text('product: ${strategy?.getProduct()}').marginOnly(top: 10.0),
            Text('supported32BitAbis: ${strategy?.getSupported32BitAbis()}').marginOnly(top: 10.0),
            Text('supported64BitAbis: ${strategy?.getSupported64BitAbis()}').marginOnly(top: 10.0),
            Text('supportedAbis: ${strategy?.getSupportedAbis()}').marginOnly(top: 10.0),
            Text('tags: ${strategy?.getTags()}').marginOnly(top: 10.0),
            Text('type: ${strategy?.getType()}').marginOnly(top: 10.0),
            Text('isPhysicalDevice: ${strategy?.isPhysicalDevice()}').marginOnly(top: 10.0),
            Text('systemFeatures: ${strategy?.getSystemFeatures()}').marginOnly(top: 10.0),
            Text('displaySizeInches: ${strategy?.getDisplaySizeInches()}').marginOnly(top: 10.0),
            Text('displayWidthPixels: ${strategy?.getDisplayWidthPixels()}').marginOnly(top: 10.0),
            Text('displayWidthInches: ${strategy?.getDisplayWidthInches()}').marginOnly(top: 10.0),
            Text('displayHeightPixels: ${strategy?.getDisplayHeightPixels()}').marginOnly(top: 10.0),
            Text('displayHeightInches: ${strategy?.getDisplayHeightInches()}').marginOnly(top: 10.0),
            Text('displayXDpi: ${strategy?.getDisplayXDpi()}').marginOnly(top: 10.0),
            Text('displayYDpi: ${strategy?.getDisplayYDpi()}').marginOnly(top: 10.0),
            Text('serialNumber: ${strategy?.getSerialNumber()}').marginOnly(top: 10.0),
          ],
        ),
      ),
    );
  }
}

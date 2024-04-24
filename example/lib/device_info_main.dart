import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/device_info_module/device_info.dart';
import 'package:flutter_rock_ui/device_info_module/device_info_strategy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DeviceInfoTest(),
    );
  }
}

class DeviceInfoTest extends StatefulWidget {
  const DeviceInfoTest({super.key});

  @override
  State<DeviceInfoTest> createState() => _DeviceInfoTestState();
}

class _DeviceInfoTestState extends State<DeviceInfoTest> {
  DeviceInfo deviceInfo = DeviceInfo();

  DeviceInfoStrategy? strategy;

  @override
  void initState() {
    getDevicePlatform();
    super.initState();
  }

  getDevicePlatform() async {
    strategy = await deviceInfo.getPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Info Demo"),
      ),
      // body: Column(
      //   children: [
      //     Text("name: ${strategy?.getName()}"),
      //     Text("systemName: ${strategy?.getSystemName()}"),
      //     Text("systemVersion: ${strategy?.getSystemVersion()}"),
      //     Text("model: ${strategy?.getModel()}"),
      //     Text("localizedModel: ${strategy?.getLocalizedModel()}"),
      //     Text("IdentifierForVendor: ${strategy?.getIdentifierForVendor()}"),
      //     Text("isPhysicalDevice: ${strategy?.isPhysicalDevice()}"),
      //     Text("utsname.sysname: ${strategy?.getUtsNameSysName()}"),
      //     Text("utsname.nodename: ${strategy?.getUtsNameNodeName()}"),
      //     Text("utsNameMachine: ${strategy?.getUtsNameMachine()}"),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('version.securityPatch: ${strategy?.getVersionSecurityPatch()}'),
            Text('version.sdkInt: ${strategy?.getVersionSdk()}'),
            Text('version.release:: ${strategy?.getVersionRelease()}'),
            Text('version.previewSdkInt: ${strategy?.getVersionPreviewSdk()}'),
            Text('version.incremental: ${strategy?.getVersionIncremental()}'),
            Text('version.codename: ${strategy?.getVersionCodename()}'),
            Text('version.baseOS: ${strategy?.getVersionBaseOS()}'),
            Text('board: ${strategy?.getBoard()}'),
            Text('bootloader: ${strategy?.getBootloader()}'),
            Text('brand: ${strategy?.getBrand()}'),
            Text('device: ${strategy?.getDevice()}'),
            Text('display: ${strategy?.getDisplay()}'),
            Text('fingerprint: ${strategy?.getFingerprint()}'),
            Text('hardware: ${strategy?.getHardware()}'),
            Text('host: ${strategy?.getHost()}'),
            Text('id: ${strategy?.getId()}'),
            Text('manufacturer: ${strategy?.getManufacturer()}'),
            Text('model: ${strategy?.getModel()}'),
            Text('product: ${strategy?.getProduct()}'),
            Text('supported32BitAbis: ${strategy?.getSupported32BitAbis()}'),
            Text('supported64BitAbis: ${strategy?.getSupported64BitAbis()}'),
            Text('supportedAbis: ${strategy?.getSupportedAbis()}'),
            Text('tags: ${strategy?.getTags()}'),
            Text('type: ${strategy?.getType()}'),
            Text('isPhysicalDevice: ${strategy?.isPhysicalDevice()}'),
            Text('systemFeatures: ${strategy?.getSystemFeatures()}'),
            Text('displaySizeInches: ${strategy?.getDisplaySizeInches()}'),
            Text('displayWidthPixels: ${strategy?.getDisplayWidthPixels()}'),
            Text('displayWidthInches: ${strategy?.getDisplayWidthInches()}'),
            Text('displayHeightPixels: ${strategy?.getDisplayHeightPixels()}'),
            Text('displayHeightInches: ${strategy?.getDisplayHeightInches()}'),
            Text('displayXDpi: ${strategy?.getDisplayXDpi()}'),
            Text('displayYDpi: ${strategy?.getDisplayYDpi()}'),
            Text('serialNumber: ${strategy?.getSerialNumber()}'),
          ],
        ),
      ),
    );
  }
}

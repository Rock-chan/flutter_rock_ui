import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_rock_ui/device_info_module/device_info_strategy.dart';

class IosDeviceInformation implements DeviceInfoStrategy {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  IosDeviceInfo? _iosDeviceInfo;

  @override
  Future<void> getDeviceInfoPlugin() async {
    _iosDeviceInfo = await deviceInfoPlugin.iosInfo;
  }

  @override
  String getIdentifierForVendor() {
    return _iosDeviceInfo!.identifierForVendor ?? "";
  }

  @override
  String getLocalizedModel() {
    return _iosDeviceInfo!.localizedModel ?? '';
  }

  @override
  String getModel() {
    return _iosDeviceInfo!.model ?? '';
  }

  @override
  String getName() {
    return _iosDeviceInfo!.name ?? '';
  }

  @override
  String getSystemName() {
    return _iosDeviceInfo!.systemName ?? '';
  }

  @override
  String getSystemVersion() {
    return _iosDeviceInfo!.systemVersion ?? '';
  }

  @override
  String getUtsNameMachine() {
    return _iosDeviceInfo!.utsname.machine ?? '';
  }

  @override
  String getUtsNameNodeName() {
    return _iosDeviceInfo!.utsname.nodename ?? '';
  }

  @override
  String getUtsNameSysName() {
    return _iosDeviceInfo!.utsname.sysname ?? '';
  }

  @override
  bool isPhysicalDevice() {
    return _iosDeviceInfo!.isPhysicalDevice;
  }

  @override
  String getBoard() {
    throw UnimplementedError();
  }

  @override
  String getBootloader() {
    throw UnimplementedError();
  }

  @override
  String getBrand() {
    throw UnimplementedError();
  }

  @override
  String getDevice() {
    throw UnimplementedError();
  }

  @override
  String getDisplay() {
    throw UnimplementedError();
  }

  @override
  double getDisplayHeightInches() {
    throw UnimplementedError();
  }

  @override
  double getDisplayHeightPixels() {
    throw UnimplementedError();
  }

  @override
  double getDisplaySizeInches() {
    throw UnimplementedError();
  }

  @override
  double getDisplayWidthInches() {
    throw UnimplementedError();
  }

  @override
  double getDisplayWidthPixels() {
    throw UnimplementedError();
  }

  @override
  double getDisplayXDpi() {
    throw UnimplementedError();
  }

  @override
  double getDisplayYDpi() {
    throw UnimplementedError();
  }

  @override
  String getFingerprint() {
    throw UnimplementedError();
  }

  @override
  String getHardware() {
    throw UnimplementedError();
  }

  @override
  String getHost() {
    throw UnimplementedError();
  }

  @override
  String getId() {
    throw UnimplementedError();
  }

  @override
  String getManufacturer() {
    throw UnimplementedError();
  }

  @override
  String getProduct() {
    throw UnimplementedError();
  }

  @override
  String getSerialNumber() {
    throw UnimplementedError();
  }

  @override
  List<String> getSupported32BitAbis() {
    throw UnimplementedError();
  }

  @override
  List<String> getSupported64BitAbis() {
    throw UnimplementedError();
  }

  @override
  List<String> getSupportedAbis() {
    throw UnimplementedError();
  }

  @override
  List<String> getSystemFeatures() {
    throw UnimplementedError();
  }

  @override
  String getTags() {
    throw UnimplementedError();
  }

  @override
  String getType() {
    throw UnimplementedError();
  }

  @override
  String getVersionBaseOS() {
    throw UnimplementedError();
  }

  @override
  String getVersionCodename() {
    throw UnimplementedError();
  }

  @override
  String getVersionIncremental() {
    throw UnimplementedError();
  }

  @override
  int getVersionPreviewSdk() {
    throw UnimplementedError();
  }

  @override
  String getVersionRelease() {
    throw UnimplementedError();
  }

  @override
  int getVersionSdk() {
    throw UnimplementedError();
  }

  @override
  String getVersionSecurityPatch() {
    throw UnimplementedError();
  }
}

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_rock_ui/device_info_module/device_info_strategy.dart';

class AndroidDeviceInformation extends DeviceInfoStrategy {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo? androidDeviceInfo;

  @override
  Future<void> getDeviceInfoPlugin() async {
    androidDeviceInfo = await deviceInfoPlugin.androidInfo;
  }

  @override
  String getIdentifierForVendor() {
    throw UnimplementedError();
  }

  @override
  String getLocalizedModel() {
    throw UnimplementedError();
  }

  @override
  String getModel() {
    return androidDeviceInfo?.model ?? '';
  }

  @override
  String getName() {
    throw UnimplementedError();
  }

  @override
  String getSystemName() {
    throw UnimplementedError();
  }

  @override
  String getSystemVersion() {
    throw UnimplementedError();
  }

  @override
  String getUtsNameMachine() {
    throw UnimplementedError();
  }

  @override
  String getUtsNameNodeName() {
    throw UnimplementedError();
  }

  @override
  String getUtsNameSysName() {
    throw UnimplementedError();
  }

  @override
  bool isPhysicalDevice() {
    return androidDeviceInfo!.isPhysicalDevice;
  }

  @override
  String getBoard() {
    return androidDeviceInfo!.board;
  }

  @override
  String getBootloader() {
    return androidDeviceInfo!.bootloader;
  }

  @override
  String getBrand() {
    return androidDeviceInfo!.brand;
  }

  @override
  String getDevice() {
    return androidDeviceInfo!.device;
  }

  @override
  String getDisplay() {
    return androidDeviceInfo!.display;
  }

  @override
  double getDisplayHeightInches() {
    return androidDeviceInfo!.displayMetrics.heightInches;
  }

  @override
  double getDisplayHeightPixels() {
    return androidDeviceInfo!.displayMetrics.heightPx;
  }

  @override
  double getDisplaySizeInches() {
    return ((androidDeviceInfo!.displayMetrics.sizeInches * 10).roundToDouble() / 10);
  }

  @override
  double getDisplayWidthInches() {
    return androidDeviceInfo!.displayMetrics.widthInches;
  }

  @override
  double getDisplayWidthPixels() {
    return androidDeviceInfo!.displayMetrics.widthPx;
  }

  @override
  double getDisplayXDpi() {
    return androidDeviceInfo!.displayMetrics.xDpi;
  }

  @override
  double getDisplayYDpi() {
    return androidDeviceInfo!.displayMetrics.yDpi;
  }

  @override
  String getFingerprint() {
    return androidDeviceInfo!.fingerprint;
  }

  @override
  String getHardware() {
    return androidDeviceInfo!.hardware;
  }

  @override
  String getHost() {
    return androidDeviceInfo!.host;
  }

  @override
  String getId() {
    return androidDeviceInfo!.id;
  }

  @override
  String getManufacturer() {
    return androidDeviceInfo!.manufacturer;
  }

  @override
  String getProduct() {
    return androidDeviceInfo!.product;
  }

  @override
  List<String> getSupported32BitAbis() {
    return androidDeviceInfo!.supported32BitAbis;
  }

  @override
  List<String> getSupported64BitAbis() {
    return androidDeviceInfo!.supported64BitAbis;
  }

  @override
  List<String> getSupportedAbis() {
    return androidDeviceInfo!.supportedAbis;
  }

  @override
  List<String> getSystemFeatures() {
    return androidDeviceInfo!.systemFeatures;
  }

  @override
  String getTags() {
    return androidDeviceInfo!.tags;
  }

  @override
  String getType() {
    return androidDeviceInfo!.type;
  }

  @override
  String getVersionBaseOS() {
    return androidDeviceInfo!.version.baseOS ?? '';
  }

  @override
  String getVersionCodename() {
    return androidDeviceInfo!.version.codename;
  }

  @override
  String getVersionIncremental() {
    return androidDeviceInfo!.version.incremental;
  }

  @override
  int getVersionPreviewSdk() {
    return androidDeviceInfo!.version.previewSdkInt ?? 0;
  }

  @override
  String getVersionRelease() {
    return androidDeviceInfo!.version.release;
  }

  @override
  int getVersionSdk() {
    return androidDeviceInfo!.version.sdkInt;
  }

  @override
  String getVersionSecurityPatch() {
    return androidDeviceInfo!.version.securityPatch ?? '';
  }

  @override
  String getSerialNumber() {
    return androidDeviceInfo!.fingerprint;
  }
}

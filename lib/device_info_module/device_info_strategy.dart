abstract class DeviceInfoStrategy {
  Future<void> getDeviceInfoPlugin();

  /// for ios
  /// 获取机器名称  iPhone
  String getName();

  /// 获取系统名称 iOS
  String getSystemName();

  /// 获取系统版本 16.3.1
  String getSystemVersion();

  /// 获取device model iPhone
  String getModel();

  /// 获取设备型号的本地化名称。iPhone
  String getLocalizedModel();

  /// 获取本机的uuid xxxxxxx-xxxxxx-xxxxxx-xxxxxx
  String getIdentifierForVendor();

  /// 获取本机是否是物理机器 true/false
  bool isPhysicalDevice();

  /// 获取本机型号 iPhone11,2
  String getUtsNameMachine();

  /// 获取本机的名称 iPhone(4)bbb
  String getUtsNameNodeName();

  /// 获取系统内核名称 Darwin
  String getUtsNameSysName();

  /// for android

  String getVersionSecurityPatch();
  int getVersionSdk();
  String getVersionRelease();
  int getVersionPreviewSdk();
  String getVersionIncremental();
  String getVersionCodename();
  String getVersionBaseOS();
  String getBoard();
  String getBootloader();
  String getBrand();
  String getDevice();
  String getDisplay();
  String getFingerprint();
  String getHardware();
  String getHost();
  String getId();
  String getManufacturer();
  String getProduct();
  List<String> getSupported32BitAbis();
  List<String> getSupported64BitAbis();
  List<String> getSupportedAbis();
  String getTags();
  String getType();
  List<String> getSystemFeatures();
  double getDisplaySizeInches();
  double getDisplayWidthPixels();
  double getDisplayWidthInches();
  double getDisplayHeightPixels();
  double getDisplayHeightInches();
  double getDisplayXDpi();
  double getDisplayYDpi();
  String getSerialNumber();
}

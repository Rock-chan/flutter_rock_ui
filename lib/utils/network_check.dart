import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_rock_ui/extensions/app_extensions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetWorkCheck {
  static void check() async {
    var result = await Connectivity().checkConnectivity();
    switch (result) {
      case ConnectivityResult.wifi:
        "您正在使用wifi".toast(toastGravity: ToastGravity.TOP);
        break;
      case ConnectivityResult.mobile:
        "您正在使用移动网络".toast(toastGravity: ToastGravity.TOP);
        break;
      case ConnectivityResult.none:
        "您暂未联网，请连接网络".toast(toastGravity: ToastGravity.TOP);
        break;
      case ConnectivityResult.bluetooth:
        "您正在使用蓝牙".toast(toastGravity: ToastGravity.TOP);
        break;
      case ConnectivityResult.ethernet:
        "您正在使用以太网".toast(toastGravity: ToastGravity.TOP);
        break;
      case ConnectivityResult.vpn:
        "您正在使用代理访问".toast(toastGravity: ToastGravity.TOP);
        break;
      case ConnectivityResult.other:
        break;
    }
  }
}

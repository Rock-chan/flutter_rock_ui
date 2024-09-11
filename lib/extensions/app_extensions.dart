import 'package:flutter/material.dart';
import 'package:flutter_rock_ui/utils/toast_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 给widget添加visible属性
extension WidgetVisibleX on Widget {
  Widget visibility(bool visible) => Visibility(visible: visible, child: this);
}

extension StringToast on String? {
  /// 显示toast
  void toast({ToastGravity? toastGravity = ToastGravity.CENTER}) => ToastUtils.showToast(this!, gravity: toastGravity);
}

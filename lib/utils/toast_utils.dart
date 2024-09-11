import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static void showToast(String msg, {ToastGravity? gravity = ToastGravity.CENTER}) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: gravity,
      backgroundColor: Colors.black.withOpacity(0.45),
      textColor: Colors.white,
    );
  }
}

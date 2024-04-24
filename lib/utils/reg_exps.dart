class RegExps {
  static RegExp phoneExp = RegExp(
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');

  static RegExp emailExp =
  RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*.\w+([-.]\w+)*$");

  static RegExp passwordExp = RegExp(r'^[a-zA-z\d]{8,}$');

  static RegExp numberExp = RegExp(r"[0-9]+$");

  static RegExp userNameExp = RegExp(r"[\u4E00-\u9FA5a-zA-Z\d]{3,}");
}

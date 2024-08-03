import 'dart:convert';

///返回json格式的String
toJson(dynamic data) {
  var je = const JsonEncoder.withIndent('  ');
  var json = je.convert(data);
  return json;
}

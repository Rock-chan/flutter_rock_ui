import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

///
/// Key-Value工具，对SharedPreferences套一层
///
class SpUtils {
  SpUtils._();

  static final SpUtils _instance = SpUtils._();

  static SpUtils get singleton => _instance;

  Future<bool> remove(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }

  Future get(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.get(key);
  }

  Future<int?> getInt(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }

  Future<bool?> getBool(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }

  Future<String?> getString(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  Future<List<String>?> getStringList(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }

  Future<Map?> getMap(String key) async {
    var sp = await SharedPreferences.getInstance();
    return json.decode(sp.getString(key) ?? "{}");
  }

  Future<bool> setInt(String key, int value) async {
    var sp = await SharedPreferences.getInstance();
    return sp.setInt(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    var sp = await SharedPreferences.getInstance();
    return sp.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    var sp = await SharedPreferences.getInstance();
    return sp.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    var sp = await SharedPreferences.getInstance();
    return sp.setStringList(key, value);
  }

  Future<bool> containsKey(String key) async {
    var sp = await SharedPreferences.getInstance();
    return sp.containsKey(key);
  }

  void saveMap(String key, Map values) async {
    var sp = await SharedPreferences.getInstance();
    await sp.setString(key, json.encode(values));
  }

  Future<bool> clear() async {
    var sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}

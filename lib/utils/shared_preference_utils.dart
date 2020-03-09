import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  static SharedPreferences preferences;

  static Future<bool> getInstance() async{
    preferences = await SharedPreferences.getInstance();
    return true;
  }

  // 异步保存
  static Future<bool> saveString(String key, String value) async {
    return preferences.setString(key, value);
  }

  static Future<bool> saveInt(String key, int value) async {
    return preferences.setInt(key, value);
  }

  static Future<bool> saveBool(String key, bool value) async {
    return preferences.setBool(key, value);
  }

  static Future<bool> saveDouble(String key, double value) async {
    return preferences.setDouble(key, value);
  }

  static Future<bool> saveStringList(String key, List<String> value) async {
    return preferences.setStringList(key, value);
  }

  // 异步读取
  static Future<String> getString(String key) async {
    return preferences.getString(key);
  }

  static Future<int> getInt(String key) async {
    return preferences.getInt(key);
  }

  static Future<bool> getBool(String key) async {
    return preferences.getBool(key);
  }

  static Future<double> getDouble(String key) async {
    return preferences.getDouble(key);
  }

  static Future<List<String>> getStringList(String key) async {
    return preferences.getStringList(key);
  }
}
import 'package:shared_preferences/shared_preferences.dart';

class ChachHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> SetData(
      {required String key, required dynamic data}) async {
    if (data is String) {
      return await sharedPreferences.setString(key, data);
    } else if (data is int) {
      return await sharedPreferences.setInt(key, data);
    } else if (data is bool) {
      return await sharedPreferences.setBool(key, data);
    } else {
      return await sharedPreferences.setDouble(key, data);
    }
  }

  static String? getData({required String key}) {
    return sharedPreferences.getString(key);
  }

  static Future<bool> removeData() async {
    return await sharedPreferences.clear();
  }
}

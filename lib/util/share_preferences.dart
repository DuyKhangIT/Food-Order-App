import 'package:shared_preferences/shared_preferences.dart';

enum SharedData {
  TOKEN,
  USERNAME,
  ID,
}
class ConfigSharedPreferences {
  /// khởi tạo shared preference and reload
  Future<SharedPreferences> getSharedPreference() async {
    SharedPreferences ref = await SharedPreferences.getInstance();
    return ref;
  }
  /// lưu giá trị vào shared preferences
  void setStringValue(String key, String value) async {
    SharedPreferences ref = await getSharedPreference();
    ref.setString(key, value);
  }
  /// lấy giá trị từ shared preferences
  Future<String> getStringValue(String key, {String? defaultValue}) async {
    SharedPreferences ref = await getSharedPreference();
    final String? returnValue = ref.getString(key);
    if (returnValue == null) return defaultValue ?? "";
    return returnValue;
  }

}
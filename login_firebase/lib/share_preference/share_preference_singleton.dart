import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesSingleton {
  SharedPreferences? _sharedPreferences;

  static final SharePreferencesSingleton instance =
      SharePreferencesSingleton._internal();

  SharePreferencesSingleton._internal();

  factory SharePreferencesSingleton(SharedPreferences sharedPreferences) {
    return instance;
  }

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  setString({required String key, required String value}) {
    _sharedPreferences?.setString(key, value);
  }

  String getString({required String key}) {
    return _sharedPreferences?.getString(key) ?? "";
  }
}

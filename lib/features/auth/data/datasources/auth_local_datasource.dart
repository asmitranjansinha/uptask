import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSource({required this.sharedPreferences});

  static const String _keyLoginStatus = "is_logged_in";
  static const String _userData = "user_data";

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    await sharedPreferences.setBool(_keyLoginStatus, isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    return sharedPreferences.getBool(_keyLoginStatus) ?? false;
  }

  Future<void> logout() async {
    await sharedPreferences.remove(_keyLoginStatus);
  }

  Future<void> saveUserData(List<String> userData) async {
    await sharedPreferences.setStringList(_userData, userData);
  }

  Future<List<String>> getUserData() async {
    return sharedPreferences.getStringList(_userData) ?? [];
  }

  Future<void> clearUserData() async {
    await sharedPreferences.remove(_userData);
  }
}

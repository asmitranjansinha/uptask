import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSource({required this.sharedPreferences});

  static const String _keyLoginStatus = "is_logged_in";

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    await sharedPreferences.setBool(_keyLoginStatus, isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    return sharedPreferences.getBool(_keyLoginStatus) ?? false;
  }

  Future<void> logout() async {
    await sharedPreferences.remove(_keyLoginStatus);
  }
}

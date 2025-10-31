import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/login_response.dart';

class AuthStorageService {
  static const String _keyToken = 'auth_token';
  static const String _keyUserData = 'user_data';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  Future<void> saveUserData(LoginData userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserData, jsonEncode(userData.toJson()));
  }

  Future<LoginData?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_keyUserData);
    if (userDataString != null) {
      return LoginData.fromJson(jsonDecode(userDataString));
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyUserData);
  }
}

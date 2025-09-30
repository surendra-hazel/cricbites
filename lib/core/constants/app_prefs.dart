import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static const String keyUserId = "user_id";
  static const String keyUserName = "user_name";
  static const String keyUserImage = "user_image";
  static const String keyEmail = "email";
  static const String keyMobileNo = "mobileNo";
  static const String keyToken = "token";
  static const String loginStatus = "login_status";

  // Save User Data
  static Future<void> saveUserData({
    required String userId,
    required String userName,
    required String userImage,
    required String email,
    required int mobileNo,
    required String token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUserId, userId);
    await prefs.setString(keyUserName, userName);
    await prefs.setString(keyEmail, email);
    await prefs.setString(keyMobileNo, mobileNo.toString());
    await prefs.setString(keyToken, token);
    await prefs.setString(keyUserImage, userImage);
  }

  static Future<void> saveUserImage(String userImage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUserImage, userImage);
  }

  static Future<bool> setLoginStatus(int value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(loginStatus, value);
  }

  // Getters
  static Future<int?> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(loginStatus);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUserId)??"0";
  }

  static Future<String?> getUserMobileNo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyMobileNo);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUserName);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyEmail);
  }
static Future<String?> getUserImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUserImage);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyToken);
  }

  // Clear (Logout)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

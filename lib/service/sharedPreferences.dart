import 'package:blood_donation_app/model/login/Userlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String _loginDataKey = "user_login_data";

  // Save login data to SharedPreferences
  Future<void> saveLoginData(Userlogin loginData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = userloginToJson(loginData);
    await prefs.setString(_loginDataKey, jsonData);
  }

  // Retrieve login data from SharedPreferences
  Future<Userlogin?> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString(_loginDataKey);
    if (jsonData != null) {
      return userloginFromJson(jsonData);
    }
    return null;
  }

  // Clear login data from SharedPreferences
  Future<void> clearLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loginDataKey);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_loginDataKey);
  }
}
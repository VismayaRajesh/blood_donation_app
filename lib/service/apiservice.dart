import 'dart:convert';
import 'package:blood_donation_app/model/login/Userlogin.dart';
import 'package:blood_donation_app/model/register/UserRegistration.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  final baseurl = "https://freeapi.luminartechnohub.com";

  // Login API
  Future<Userlogin?> login(String email, String password) async {
    var url = Uri.parse("$baseurl/login");

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var body = jsonEncode({
      "email": email,
      "password": password,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var json = jsonDecode(response.body);
        return Userlogin.fromJson(json);
      } else {
        // Handle non-200 responses
        print("Login failed with status: ${response.statusCode}");
        print("Response body: ${response.body}");
        return null;
      }
    } catch (e) {
      // Log exception
      print("Login error: $e");
      return null;
    }
  }

  // Registration API
  Future<bool> registration(String name, int phone, String place, int pincode, String email, String password) async {
    var url = Uri.parse("$baseurl/registration/");

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var body = jsonEncode({
      "name": name,
      "phone": phone,
      "place": place,
      "pincode": pincode,
      "email": email,
      "password": password
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        print("Registration successful: ${response.body}");
        return true; // Registration was successful
      } else {
        // Handle non-200 responses
        print("Registration failed with status: ${response.statusCode}");
        print("Response body: ${response.body}");
        return false; // Registration failed
      }
    } catch (e) {
      // Log exception
      print("Registration error: $e");
      return false; // Registration failed due to an exception
    }
  }
}

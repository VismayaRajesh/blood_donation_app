import 'dart:convert';

import 'package:blood_donation_app/model/login/Userlogin.dart';
import 'package:blood_donation_app/model/register/UserRegistration.dart';
import 'package:http/http.dart' as http;
class Apiservice{
  final baseurl = "https://freeapi.luminartechnohub.com";

  Future<Userlogin?> login(String email, String password) async {
    var url = Uri.parse("$baseurl/login");

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };

    var body = jsonEncode({
      "email" : email,
      "password" : password
    });

    try{
      final response = await http.post(url, headers: headers, body: body);
      if(response.statusCode >= 200 && response.statusCode <= 299){
        var jsonn = jsonDecode(response.body);
        return Userlogin.fromJson(jsonn);
      }
    }
    catch(e){
      print("$e");
    }
  }

  Future<UserRegistration?> registration(String name, int phone, String place, int pincode, String email, String password) async {
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

    try{
      final response = await http.post(url, headers: headers, body: body);
      if(response.statusCode >= 200 && response.statusCode <= 299){
        var jsonn = jsonDecode(response.body);
        print("${response.body}");
        return UserRegistration.fromJson(jsonn);
      }
    }
    catch(e){
      print("$e");
    }

  }
}
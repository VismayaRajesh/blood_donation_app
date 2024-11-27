import 'Data.dart';
import 'Tokens.dart';
import 'dart:convert';

UserRegistration userRegistrationFromJson(String str) => UserRegistration.fromJson(json.decode(str));
String userRegistrationToJson(UserRegistration data) => json.encode(data.toJson());
class UserRegistration {
  UserRegistration({
      this.status, 
      this.msg, 
      this.data, 
      this.tokens,});

  UserRegistration.fromJson(dynamic json) {
    status = json['Status'];
    msg = json['Msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }
  String? status;
  String? msg;
  Data? data;
  Tokens? tokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (tokens != null) {
      map['tokens'] = tokens?.toJson();
    }
    return map;
  }

}
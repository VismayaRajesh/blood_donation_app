import 'dart:convert';

Userlogin userloginFromJson(String str) => Userlogin.fromJson(json.decode(str));
String userloginToJson(Userlogin data) => json.encode(data.toJson());
class Userlogin {
  Userlogin({
      this.refresh, 
      this.access, 
      this.id, 
      this.name, 
      this.place, 
      this.email,});

  Userlogin.fromJson(dynamic json) {
    refresh = json['refresh'];
    access = json['access'];
    id = json['id'];
    name = json['name'];
    place = json['place'];
    email = json['email'];
  }
  String? refresh;
  String? access;
  num? id;
  String? name;
  String? place;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = refresh;
    map['access'] = access;
    map['id'] = id;
    map['name'] = name;
    map['place'] = place;
    map['email'] = email;
    return map;
  }

}
class User {
  int? id;
  late String name;
  late String location;
  late String bloodType;
  late String phone;

  User({this.id, required this.name, required this.location, required this.bloodType, required this.phone});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "name": name,
      "location": location,
      "bloodType": bloodType,
      "phone" : phone,

    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }
}

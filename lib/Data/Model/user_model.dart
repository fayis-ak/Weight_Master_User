class UserModel {
  String uid;
  String email;
  String password;
  String name;
  String address;

  UserModel(
      {
      required this.address,
      required this.email,
      required this.name,
      required this.password,
      required this.uid});

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "email": email,
        "password": password,
         "address": address
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        address: json["address"],
        email: json["email"],
        name: json["name"],
        password: json["password"],
        uid: json["uid"]);
  }
}

class AddressModel {}

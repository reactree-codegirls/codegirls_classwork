import 'package:flutter_cg/models/addressModel.dart';

class UserModel {
  String name;
  String userName;
  String email;
  AddressModel address;

  UserModel({this.name, this.userName, this.email, this.address});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json["email"],
        name: json["name"],
        userName: json["username"],
        address: AddressModel.fromJson(json["address"]));
  }

  printTheName() {
    print(this.name);
  }
}

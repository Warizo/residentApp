// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.status,
    this.message,
    this.user,
  });

  bool? status;
  String? message;
  UserClass? user;

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        message: json["message"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user?.toJson(),
      };
}

class UserClass {
  UserClass({
    this.id,
    this.email,
    this.password,
    this.isActivate,
    this.residenceId,
  });

  int? id;
  String? email;
  String? password;
  String? isActivate;
  String? residenceId;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["Id"],
        email: json["Email"],
        password: json["Password"],
        isActivate: json["IsActivate"],
        residenceId: json["ResidenceID"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Email": email,
        "Password": password,
        "IsActivate": isActivate,
        "ResidenceID": residenceId,
      };
}

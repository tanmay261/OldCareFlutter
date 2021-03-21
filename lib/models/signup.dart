// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    this.token,
    this.userDetails,
  });

  String token;
  UserDetails userDetails;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        token: json["token"],
        userDetails: UserDetails.fromJson(json["userDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "userDetails": userDetails.toJson(),
      };
}

class UserDetails {
  UserDetails({
    this.name,
    this.email,
    this.password,
    this.userId,
  });

  String name;
  String email;
  String password;
  int userId;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "userId": userId,
      };
}

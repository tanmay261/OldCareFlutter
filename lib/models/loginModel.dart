// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        this.token,
        this.userDetails,
    });

    String token;
    UserDetails userDetails;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    });

    String name;
    String email;
    String password;

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        name: json["name"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
    };
}

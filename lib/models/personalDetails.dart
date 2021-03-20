// To parse this JSON data, do
//
//     final personalDetailModel = personalDetailModelFromJson(jsonString);

import 'dart:convert';

PersonalDetailModel personalDetailModelFromJson(String str) =>
    PersonalDetailModel.fromJson(json.decode(str));

String personalDetailModelToJson(PersonalDetailModel data) =>
    json.encode(data.toJson());

class PersonalDetailModel {
  PersonalDetailModel({
    this.name,
    this.age,
    this.mobileno,
    this.countryCode,
    this.timezone,
    this.weight,
    this.height,
  });

  String name;
  String age;
  String mobileno;
  String countryCode;
  String timezone;
  String weight;
  String height;

  factory PersonalDetailModel.fromJson(Map<String, dynamic> json) =>
      PersonalDetailModel(
        name: json["name"],
        age: json["age"],
        mobileno: json["mobileno"],
        countryCode: json["country_code"],
        timezone: json["timezone"],
        weight: json["weight"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "mobileno": mobileno,
        "country_code": countryCode,
        "timezone": timezone,
        "weight": weight,
        "height": height,
      };
}

// To parse this JSON data, do
//
//     final footstepsModel = footstepsModelFromJson(jsonString);

import 'dart:convert';

FootstepsModel footstepsModelFromJson(String str) =>
    FootstepsModel.fromJson(json.decode(str));

String footstepsModelToJson(FootstepsModel data) => json.encode(data.toJson());

class FootstepsModel {
  FootstepsModel({
    this.date,
    this.option,
  });

  DateTime date;
  String option;

  factory FootstepsModel.fromJson(Map<String, dynamic> json) => FootstepsModel(
        date: DateTime.parse(json["date"]),
        option: json["option"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "option": option,
      };
}

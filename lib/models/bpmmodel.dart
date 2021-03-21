// To parse this JSON data, do
//
//     final bpmModel = bpmModelFromJson(jsonString);

import 'dart:convert';

BpmModel bpmModelFromJson(String str) => BpmModel.fromJson(json.decode(str));

String bpmModelToJson(BpmModel data) => json.encode(data.toJson());

class BpmModel {
  BpmModel({
    this.date,
    this.option,
  });

  DateTime date;
  String option;

  factory BpmModel.fromJson(Map<String, dynamic> json) => BpmModel(
        date: DateTime.parse(json["date"]),
        option: json["option"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "option": option,
      };
}

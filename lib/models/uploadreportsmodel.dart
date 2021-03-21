// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

import 'dart:convert';

ReportModel reportModelFromJson(String str) => ReportModel.fromJson(json.decode(str));

String reportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
    ReportModel({
        this.title,
        this.summary,
    });

    String title;
    String summary;

    factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        title: json["title"],
        summary: json["summary"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "summary": summary,
    };
}

// To parse this JSON data, do
//
//     final sugarModel = sugarModelFromJson(jsonString);

import 'dart:convert';

SugarModel sugarModelFromJson(String str) => SugarModel.fromJson(json.decode(str));

String sugarModelToJson(SugarModel data) => json.encode(data.toJson());

class SugarModel {
    SugarModel({
        this.levels,
    });

    List<Level> levels;

    factory SugarModel.fromJson(Map<String, dynamic> json) => SugarModel(
        levels: List<Level>.from(json["levels"].map((x) => Level.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "levels": List<dynamic>.from(levels.map((x) => x.toJson())),
    };
}

class Level {
    Level({
        this.id,
        this.elderId,
        this.level,
        this.createdAt,
    });

    int id;
    int elderId;
    int level;
    DateTime createdAt;

    factory Level.fromJson(Map<String, dynamic> json) => Level(
        id: json["id"],
        elderId: json["elderId"],
        level: json["level"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "elderId": elderId,
        "level": level,
        "created_at": createdAt.toIso8601String(),
    };
}

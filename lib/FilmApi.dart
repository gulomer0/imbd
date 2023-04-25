// To parse this JSON data, do
//
//     final filmler = filmlerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Filmler {
  Filmler({
    required this.success,
    required this.result,
  });

  bool success;
  List<Result> result;

  factory Filmler.fromRawJson(String str) => Filmler.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Filmler.fromJson(Map<String, dynamic> json) => Filmler(
        success: json["success"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.type,
    required this.poster,
  });

  String title;
  String year;
  String imdbId;
  String type;
  String poster;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["Title"],
        year: json["Year"],
        imdbId: json["imdbID"],
        type: json["Type"],
        poster: json["Poster"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Year": year,
        "imdbID": imdbId,
        "Type": type,
        "Poster": poster,
      };
}

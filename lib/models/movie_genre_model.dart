import 'dart:convert';

class MovieGenreModel {
  final int id;
  final String name;

  MovieGenreModel({this.id, this.name});

  factory MovieGenreModel.fromJsom(String str) =>
      MovieGenreModel.fromMap(json.decode(str));

  factory MovieGenreModel.fromMap(Map<String, dynamic> json) =>
      MovieGenreModel(id: json["id"], name: json["name"]);
}

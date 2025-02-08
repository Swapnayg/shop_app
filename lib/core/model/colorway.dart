import 'package:flutter/cupertino.dart';

class Colorway {
  String name;
  Color color;

  Colorway({required this.name, required this.color});

  factory Colorway.fromJson(Map<String, dynamic> json) {
    return Colorway(name: json['name'], color: json['color']);
  }
}

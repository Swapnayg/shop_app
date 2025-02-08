//import 'package:flutter/cupertino.dart';

class exploreItem {
  final String imageUrl;

  exploreItem({required this.imageUrl});

  factory exploreItem.fromJson(Map<String, dynamic> json) {
    return exploreItem(imageUrl: json['image_url']);
  }
}

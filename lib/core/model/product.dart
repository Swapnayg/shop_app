import 'package:flutter/cupertino.dart';
import 'package:shop_app/core/model/colorway.dart';
import 'package:shop_app/core/model/ProductSize.dart';
import 'package:shop_app/core/model/Review.dart';

class Product {
  List<String> image;
  String? name;
  int? price;
  double? rating;
  String? description;
  List<Colorway> colors;
  List<ProductSize> sizes;
  List<Review_p> reviews;
  String? storeName;

  Product({
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
    required this.colors,
    required this.sizes,
    required this.reviews,
    required this.storeName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        image: json['image'],
        name: json['name'],
        price: json['price'],
        rating: json['rating'],
        description: json['description'],
        colors: (json['colors'] as List)
            .map((data) => Colorway.fromJson(data))
            .toList(),
        sizes: (json['sizes'] as List)
            .map((data) => ProductSize.fromJson(data))
            .toList(),
        reviews: (json['reviews'] as List)
            .map((data) => Review_p.fromJson(data))
            .toList(),
        storeName: json['store_name'],
      );
    } catch (e) {
      debugPrint(e.toString());
      return Product(
        image: [],
        name: "",
        price: 0,
        rating: 0,
        description: "",
        colors: [],
        sizes: [],
        reviews: [],
        storeName: "",
      );
    }
  }
}

import 'dart:collection';

import 'package:flutter/foundation.dart';

class Product {
  final num id;
  final String title;
  final String description;
  final String imgUrl;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imgUrl
  });
}

class Products {
  static final List<Product> items = [
];

}
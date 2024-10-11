import 'dart:collection';

import 'package:flutter/foundation.dart';

class Product {
  final num id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imgUrl
  });
}

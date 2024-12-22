import 'package:flutter/material.dart';

class ProductModel {
  ProductModel(
      this.id,
      this.title,
      this.subtitle,
      this.imageUri,
      this.price,
      this.isFavorite,
      );

  int? id;
  String title;
  String subtitle;
  String imageUri;
  double price;
  bool isFavorite = false;

  IconData getFavoriteIconData() {
    if (isFavorite) {
      return Icons.favorite_outlined;
    } else {
      return Icons.favorite_outline;
    }
  }
}
import 'package:untitled/models/product.dart';

class CartItem extends Product {
  int count;

  CartItem(this.count, {
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.imgUrl,
  });

  // void incrementCount() {
  //   count++;
  // }
  //
  // void decrementCount() {
  //   if (count > 1) {
  //     count--;
  //   }
  // }
}

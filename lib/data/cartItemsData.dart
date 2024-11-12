import 'package:untitled/models/productItem.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Cart {
  final List<CartItem> items = [];


  void add(Product product) {
    final existingItem = items.firstWhere(
          (item) => item.product == product,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity++;
    } else {
      items.add(CartItem(product: product, quantity: 1));
    }
  }

  void remove(Product product) {
    final existingItem = items.firstWhere(
          (item) => item.product == product,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > 1) {
      existingItem.quantity--;
    } else if (existingItem.quantity == 1) {
      items.removeWhere((item) => item.product == product);
    }
  }

  double get totalAmount {
    return items.fold(0, (sum, item) => sum + item.product.price * item.quantity);
  }
}

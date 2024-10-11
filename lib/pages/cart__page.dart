import 'package:flutter/material.dart';
import 'package:untitled/models/CartItem.dart';

class CartPage extends StatefulWidget {
  final Set<CartItem> cartItems;
  final Function(CartItem) removeCartItem;

  const CartPage({Key? key, required this.cartItems, required this.removeCartItem}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  double calculateTotal() {
    return widget.cartItems.fold(0, (sum, item) => sum + (item.price * item.count));
  }

  @override
  Widget build(BuildContext context) {
    double total = calculateTotal();

    return Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Итого: ${total.toStringAsFixed(total.truncateToDouble() == total ? 0 : 1)} ₽',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Оформить заказ'),
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text('Корзина')),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('В корзине ничего нет'))
          : ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = widget.cartItems.elementAt(index);
          final cartItemPrice = cartItem.price * cartItem.count;
          final cartItemFinalPrice = cartItemPrice.toStringAsFixed(cartItemPrice.truncateToDouble() == cartItemPrice ? 0 : 1);

          return ListTile(
            leading: Image.network(cartItem.imgUrl),
            title: Text(cartItem.title),
            subtitle: Text(
              'Количество: ${cartItem.count}\nЦена: $cartItemFinalPrice ₽',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (cartItem.count > 1) {
                        cartItem.count--;
                      } else {
                        widget.removeCartItem(cartItem);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      cartItem.count++;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/models/CartItem.dart';
import 'package:untitled/models/product.dart';

class ProductPage extends StatefulWidget {
  final Product item;
  final VoidCallback onDelete;
  final Set<Product> favoriteProducts;
  final Function(Product) onFavoriteToggle;
  final Function(Product) onAddToCart;
  final Function(CartItem) removeCartItem;

  const ProductPage({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.favoriteProducts,
    required this.onFavoriteToggle,
   required this.onAddToCart,
    required this.removeCartItem
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  void _removeCard(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение удаления'),
          content: const Text('Вы уверены, что хотите удалить этот товар?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог без удаления
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                widget.onDelete();
                Navigator.of(context).pop();
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Итого: ${widget.item.price.toStringAsFixed(widget.item.price.truncateToDouble() == widget.item.price ? 0 : 1) + " ₽"}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onAddToCart(widget.item);
              },
              child: const Text('Добавить в корзину'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('back'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _removeCard(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Column(
              children: [
                Text(
                  widget.item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: NetworkImage(widget.item.imgUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 300),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.onFavoriteToggle(widget.item);
                        });
                      },
                      icon: widget.favoriteProducts.contains(widget.item)
                          ? const Icon(Icons.favorite, size: 36, color: Colors.red)
                          : const Icon(Icons.favorite_border, size: 36, color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Hero History',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.item.description,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

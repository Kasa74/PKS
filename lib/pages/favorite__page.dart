import 'package:flutter/material.dart';
import 'package:untitled/models/CartItem.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/product_card_page.dart';

class FavoritePage extends StatefulWidget {
  final Set<Product> favoriteProducts;
  final Function(Product) onFavoriteToggle;
  final Function(Product) onAddToCart;
  final Function(CartItem) removeCartItem;



  const FavoritePage({
    Key? key,
    required this.favoriteProducts,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.removeCartItem,
  }) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: widget.favoriteProducts.isEmpty
          ? const Center(child: Text('Нет избранных карточек'))
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        padding: const EdgeInsets.only(left: 20, right: 20),
        itemCount: widget.favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = widget.favoriteProducts.elementAt(index);
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(
                  item: product,
                  removeCartItem: widget.removeCartItem,
                  onAddToCart: (item) {
                    widget.onAddToCart(item);
                  },
                  favoriteProducts: widget.favoriteProducts,
                  onFavoriteToggle: (item) {
                    setState(() {
                      widget.onFavoriteToggle(item);
                    });
                  },
                  onDelete: () {
                    setState(() {
                      widget.onFavoriteToggle(product);
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  image: NetworkImage(product.imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Text(
                      product.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100, right: 120),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.onFavoriteToggle(product);
                        });
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/product_card_page.dart';

class FavoritePage extends StatelessWidget {
  final Set<Product> favoriteProducts;
  final Function(Product) onFavoriteToggle;

  const FavoritePage({
    Key? key,
    required this.favoriteProducts,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
      ),
      body: favoriteProducts.isEmpty
          ? Center(child: Text('Нет избранных карточек'))
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        padding: EdgeInsets.only(left: 20, right: 20),
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts.elementAt(index);
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(
                  item: product,
                  onDelete: () {
                    onFavoriteToggle(product);
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
                    padding: EdgeInsets.only(top: 100, right: 120),
                    child: IconButton(
                      onPressed: () {
                        onFavoriteToggle(product);
                      },
                      icon: Icon(
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

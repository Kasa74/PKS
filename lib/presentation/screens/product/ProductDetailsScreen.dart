import 'package:flutter/material.dart';
import 'package:flutter_task3/presentation/models/ProductModel.dart';

import '../../../data/ProductsData.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onDeleteClicked;
  final VoidCallback onInCartPressed;
  final VoidCallback onLikeClicked;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onDeleteClicked,
    required this.onInCartPressed,
    required this.onLikeClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      product.imageUri,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      product.title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Text(
                      "${product.cost}₽",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      product.subtitle,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              children: [
                IconButton(
                    onPressed: () {
                      onLikeClicked();
                    },
                    icon: Icon(product.getFavoriteIconData())
                ),
                const SizedBox(
                  width: 8,
                ),
                OutlinedButton(
                  onPressed: () {
                    onInCartPressed();
                  },
                  child: const Text("В корзину")
                ),
                const SizedBox(
                  width: 8,
                ),
                OutlinedButton(
                  onPressed: () {
                    onDeleteClicked();
                    if (product.id != null) {
                      deleteProduct(product.id!);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text("Удалить")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
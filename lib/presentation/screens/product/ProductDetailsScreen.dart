import 'package:flutter/material.dart';
import 'package:flutter_task3/presentation/models/ProductModel.dart';

import '../../../data/favorite_service.dart';
import '../../../data/products_service.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductModel product;
  final VoidCallback onDeleteClicked;
  final VoidCallback onInCartPressed;
  final ValueChanged<ValueChanged<ProductModel>> onEditPressed;

  ProductDetailScreen({
    super.key,
    required this.product,
    required this.onDeleteClicked,
    required this.onInCartPressed,
    required this.onEditPressed,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductModel product;

  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ValueChanged<ProductModel> onProductEdited = (newProduct) => setState(() {
      product = newProduct;
    });

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
                      "${product.price} \$",
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
                      if (product.isFavorite) {
                        unlikeProduct(product.id!);
                      }
                      else {
                        likeProduct(product.id!);
                      }

                      setState(() {
                        product.isFavorite = !product.isFavorite;
                      });

                      if (product.id == null) {
                        return;
                      }
                    },
                    icon: Icon(product.getFavoriteIconData())
                ),
                const SizedBox(
                  width: 8,
                ),
                OutlinedButton(
                    onPressed: () {
                      widget.onInCartPressed();
                    },
                    child: const Text("В корзину")
                ),
                const SizedBox(
                  width: 8,
                ),
                OutlinedButton(
                    onPressed: () {
                      widget.onDeleteClicked();
                      if (widget.product.id != null) {
                        deleteProduct(widget.product.id!);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text("Удалить")
                ),
                const SizedBox(
                  width: 8,
                ),
                OutlinedButton(
                    onPressed: () {
                      widget.onEditPressed(onProductEdited);
                    },
                    child: const Text("Изм.")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
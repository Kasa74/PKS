import 'package:flutter/material.dart';
import 'package:flutter_task3/presentation/models/ProductModel.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback onLikeClicked;

  const ProductWidget({
    super.key,
    required this.product,
    required this.onTap,
    required this.onLikeClicked,
});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.network(
                    product.imageUri,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        onLikeClicked();
                      },
                      icon: Icon(product.getFavoriteIconData())
                  ),
                ],
              ),
              Text(
                  "${product.cost}₽",
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w700
                ),
              ),
              Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
              Text(
                  product.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
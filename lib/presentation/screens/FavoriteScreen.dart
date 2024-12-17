import 'package:flutter/material.dart';
import 'package:flutter_task3/data/ShoppingCartData.dart';
import 'package:flutter_task3/presentation/models/ShopCartItemModel.dart';
import 'package:flutter_task3/presentation/screens/product/ProductDetailsScreen.dart';

import '../../data/ProductsData.dart';
import '../widgets/ProductWidget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var products = [];

  @override
  void initState() {
    super.initState();
    products.addAll(sharedProducts.where((element) => element.isFavorite));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              var product = products[index];
              return ProductWidget(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product,
                        onDeleteClicked: () {
                        setState(() {
                          products.remove(product);
                          initialShoppingCartData.removeWhere((element) => element.id == product.id);
                          sharedProducts.remove(product);
                        });
                      }, onInCartPressed: () {
                        initialShoppingCartData.add(ShopCartItemModel(
                            product.id,
                            product.title,
                            product.subtitle,
                            product.imageUri,
                            product.cost,
                            1
                        ));
                      },
                        onLikeClicked: () {
                        setState(() {
                          product.isFavorite = !product.isFavorite;
                        });
                      },),
                    ),
                  );
                },
                onLikeClicked: () {
                  setState(() {
                    product.isFavorite = !product.isFavorite;
                  });
              },
              );
              },
          ),
      )
    );
  }
}

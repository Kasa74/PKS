import 'package:flutter/material.dart';
import 'package:flutter_task3/data/ProductsData.dart';
import 'package:flutter_task3/presentation/screens/product/CreateProductScreen.dart';
import 'package:flutter_task3/presentation/screens/product/ProductDetailsScreen.dart';
import 'package:flutter_task3/presentation/widgets/ProductWidget.dart';

import '../../data/ShoppingCartData.dart';
import '../models/ShopCartItemModel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var products = [];

  @override
  void initState() {
    super.initState();
    var futureProducts = getProducts();
    futureProducts.then((value) => {
      setState(() {
        products.addAll(value);
      })
    });
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
                    builder: (context) => ProductDetailScreen(
                      product: product,
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
                      }, onLikeClicked: () {
                        setState(() {
                          product.isFavorite = !product.isFavorite;
                        });
                      },
                    ),
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
      ),
      floatingActionButton: FloatingActionButton.small(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateProductScreen(
              onProductCreated: (product) {
                setState(() {
                  products.add(product!);
                });
              },
            )
          ),
        );
      },
        child: const Icon(Icons.add),
      ),
    );
  }
}

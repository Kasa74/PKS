import 'package:flutter/material.dart';
import 'package:flutter_task3/data/CartService.dart';
import 'package:flutter_task3/data/products_service.dart';
import 'package:flutter_task3/presentation/screens/product/CreateProductScreen.dart';
import 'package:flutter_task3/presentation/screens/product/EditProductScreen.dart';
import 'package:flutter_task3/presentation/screens/product/ProductDetailsScreen.dart';
import 'package:flutter_task3/presentation/widgets/ProductWidget.dart';


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
    var futureProducts = initializeProducts();
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
                      product: products[index],
                      onDeleteClicked: () {
                        setState(() {
                          products.remove(product);
                          deleteProductFromCart(product);
                          sharedProducts.remove(product);
                        });
                      }, onInCartPressed: () {
                      increaseCartItemCount(product.id);
                    },
                      onEditPressed: (onEdited) {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => EditProductScreen(
                              onProductEdited: (newProduct) {
                                onEdited(newProduct);
                                var productsFuture = getProducts();
                                productsFuture.then((value) =>
                                    setState(() {
                                      products = value;
                                    })
                                );
                                setState(() {
                                  sharedProducts[index] = newProduct;
                                });
                              },
                              productModel: product,
                            )
                        ));
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
import 'package:flutter/material.dart';
import 'package:flutter_task3/data/ProductsData.dart';
import 'package:flutter_task3/presentation/models/ShopCartItemModel.dart';
import 'package:flutter_task3/presentation/screens/product/ProductDetailsScreen.dart';
import 'package:flutter_task3/presentation/widgets/ShopCartItem.dart';

import '../../../data/ShoppingCartData.dart';
import 'BottomBar.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<ShopCartItemModel> items = initialShoppingCartData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                var item = items[index];
                var product = sharedProducts.firstWhere((element) => item.id == element.id);

                return ShopCartItem(
                  item: item,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: product,
                          onDeleteClicked: () {
                            setState(() {
                              items.remove(item);
                              sharedProducts.removeWhere((element) => element.id == item.id);
                            });
                            },
                          onInCartPressed: () {},
                          onLikeClicked: () {
                            setState(() {
                              var product = sharedProducts.firstWhere((element) => element.id == item.id);
                              product.isFavorite = !product.isFavorite;
                            });
                            },
                        ),
                      ),
                    );
                  },
                  onCountChanged: (int value) {
                    setState(() {
                      item.count = value;
                    });
                    },
                  deleteItem: () {
                    setState(() {
                      items.remove(item);
                    });
                  },
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ShoppingCartBottomBar(
              totalPrice: sumPrices(),
              totalCount: getCartTotalCount(),
            ),
          ),
        ],
      )
    );
  }

  int getCartTotalCount() {
    int count = 0;

    for (int i = 0; i < items.length; i++) {
      count = count + items[i].count;
    }
    return count;
  }

  double sumPrices() {
    double sum = 0;

    for (int i = 0; i < items.length; i++) {
      sum += items[i].cost * items[i].count;
    }
    return sum;
  }
}

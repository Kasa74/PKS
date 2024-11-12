import 'package:flutter/material.dart';
import 'package:untitled/data/cartItemsData.dart';
import 'package:untitled/data/productItemsData.dart';

class HomePage extends StatefulWidget {
  final Cart cart;
  const HomePage({super.key, required this.cart});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 92, left: 27.5, right: 27.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Каталог Услуг',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.08,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: productItems.length,
                itemBuilder: (context, index) {
                  final product = productItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      width: double.infinity,
                      height: 136,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF898A8D), width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text(
                              product.text,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.05,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            bottom: 28,
                            child: Text(
                              product.duration,
                              style: TextStyle(
                                color: Color(0xFF939396),
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Text(
                              '${product.price.toStringAsFixed(0)} ₽',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.cart.add(product);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1A6FEE),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Добавить',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

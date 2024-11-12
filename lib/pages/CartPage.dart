import 'package:flutter/material.dart';
import 'package:untitled/data/cartItemsData.dart';

class CartPage extends StatefulWidget {
  final Cart cart;
  const CartPage({super.key, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.cart.items.isEmpty
          ? Center(child: Text('Корзина пуста'))
          : Padding(
        padding: EdgeInsets.only(top: 92, left: 27.5, right: 27.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Корзина',
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
                itemCount: widget.cart.items.length + 1,
                itemBuilder: (context, index) {

                  if (index < widget.cart.items.length){
                    final cartItem = widget.cart.items[index];
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
                            Positioned(
                              top: 5,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.cart.remove(cartItem.product);
                                  });
                                },
                                child: Image.asset('assets/img/Delete.png'),
                              ),
                            ),

                              Text(
                                cartItem.product.text,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.05,
                                ),
                              ),

                            Positioned(
                              left: 0,
                              bottom: 10,
                              child: Text(
                                textAlign: TextAlign.center,
                                '${cartItem.product.price.toStringAsFixed(0)} ₽',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -10,
                              bottom: 0,
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('${cartItem.quantity} пациент',
                                    style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                  ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Container(

                                      alignment: Alignment.center,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFF5F5F9),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                widget.cart.remove(cartItem.product);
                                              });
                                            },
                                            icon: Icon(Icons.remove, size: 20,),
                                          ),
                                          Container(
                                            width: 1,
                                            height: 20,
                                            color: Colors.grey.withOpacity(0.3),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                widget.cart.add(cartItem.product);
                                              });
                                            },
                                            icon: Icon(Icons.add, size: 20,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return            Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Сумма',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${widget.cart.totalAmount.toStringAsFixed(0)} ₽',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }


                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}

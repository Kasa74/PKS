import 'package:flutter/material.dart';
import 'package:untitled/components/product_card.dart';
import 'package:untitled/pages/product_card_page.dart';
import 'package:untitled/models/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: SafeArea(

        child: Container(
          height: MediaQuery.of(context).size.height - 85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)
            )
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: Products.items.length,
              itemBuilder: (BuildContext context, int index) {
              return ProductCard(item: Products.items[index],);
              }
          ),
        ),
      )
      );
  }
}


// body:
// ListView.builder(
// itemCount: 33,
// itemBuilder: (BuildContext context, int index) {
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: const Color.fromARGB(255, 10, 1, 55)),
// width: double.infinity,
// height: MediaQuery.of(context).size.height * 0.4,
// child: Column(
// children: [
// Center(child: Text('entry', style: TextStyle(color: Colors.white,fontSize: 34),),),
// SizedBox(height: 60),
// Text('dolor sit ', style: TextStyle(color: Colors.white, fontSize: 16))
// ],
// ),
// ),
// );
// }
// ),
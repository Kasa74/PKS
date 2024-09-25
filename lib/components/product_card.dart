import 'package:flutter/material.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/product_card_page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.item});

  final Product item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductPage(item: item,)),
      ),
      child: Padding(

        padding: const EdgeInsets.only(left: 100, right: 100, top: 10, bottom: 10),
        child: Container(

          alignment: Alignment.topCenter,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(image: NetworkImage(item.imgUrl), fit: BoxFit.cover)
          ),
              child: Padding(
                padding: const EdgeInsets.only(),
                child: Text(item.title,style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
              ),
        ),
      ),
    );
  }
}

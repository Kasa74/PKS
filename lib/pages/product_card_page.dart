import 'package:flutter/material.dart';
import 'package:untitled/models/product.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.item});

  final Product item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('back', )),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Column(children: [ Container(
              alignment: Alignment.topCenter,
              height: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(image: NetworkImage(item.imgUrl), fit: BoxFit.cover)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(item.title,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),),
              ),
            ),
              Container(
                padding: EdgeInsets.only(top: 20 ),
                alignment: Alignment.topLeft,
                child: Text('Hero History',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  alignment: Alignment.topLeft,
                    child: Text(item.description, style: TextStyle(fontSize: 20),)),
              )
      ],
    )
          ),


        ],
      ),
    );
  }
}

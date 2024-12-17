import 'package:flutter/material.dart';
import 'package:flutter_task3/presentation/models/ProductModel.dart';
import 'package:flutter_task3/presentation/widgets/MyNumericFieldWidget.dart';
import 'package:flutter_task3/presentation/widgets/MyTextFieldWidget.dart';

import '../../../data/ProductsData.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({
    super.key,
    required this.onProductCreated
  });

  final ValueChanged<ProductModel?> onProductCreated;

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState(
    onProductCreated: onProductCreated
  );
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  String title = "";
  String subtitle = "";
  double price = 0;
  String imageLink = "";

  final ValueChanged<ProductModel?> onProductCreated;

  _CreateProductScreenState({
    required this.onProductCreated
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyTextFieldWidget(
              onChanged: (text) { title = text; },
              hintText: "Название"
          ),
          MyTextFieldWidget(
              onChanged: (text) { subtitle = text; },
              hintText: "Описание"
          ),
          MyNumericFieldWidget(
              onChanged: (text) {
                try {
                  price = double.parse(text);
                }
                catch(e) {
                  price = 0;
                }
              },
              hintText: "Стоимость"
          ),
          MyTextFieldWidget(
              onChanged: (text) { imageLink = text; },
              hintText: "Ссылка на изображение"
          ),

          const Spacer(),
          OutlinedButton(
              onPressed: () {
                var newProduct = ProductModel(
                    null,
                    title,
                    subtitle,
                    imageLink,
                    price,
                    false
                );
                createProduct(newProduct);
                onProductCreated(newProduct);

                Navigator.pop(context);
              },
              child: const Text("Добавить")
          ),
        ],
      ),
    );
  }
}

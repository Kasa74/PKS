import 'dart:convert';

import 'package:flutter_task3/data/UserService.dart';
import 'package:flutter_task3/presentation/models/ProductModel.dart';

import '../presentation/models/ShopCartItemModel.dart';
import 'dio_config.dart';

Future<List<ShopCartItemModel>> getCart() async {
  var userId = getUserId();
  var response = await getHttpClient().get(
      "/cart/$userId"
  );

  var cartItems = jsonDecode(response.data);
  List<ShopCartItemModel> list = [];

  for (var cartItem in cartItems) {
    var deserialized = deserializeCartItem(cartItem);
    list.add(deserialized);
  }

  return list;
}

void deleteProductFromCart(ProductModel product) async {
  var userId = getUserId();

  await getHttpClient().delete(
      "/cart/$userId/${product.id}"
  );
}

void deleteCartItem(ShopCartItemModel model) async {
  var userId = getUserId();

  await getHttpClient().delete(
      "/cart/$userId/${model.id}"
  );
}

void decreaseCartItemCount(int productId) async {
  var userId = getUserId();

  var request = {
    'product_id': productId,
    'quantity': 1
  };

  await getHttpClient().put(
      "/cart/$userId",
      data: request
  );
}

void increaseCartItemCount(int productId) async {
  var userId = getUserId();

  var request = {
    'product_id': productId,
    'quantity': 1
  };

  await getHttpClient().post(
      "/cart/$userId",
      data: request
  );
}

ShopCartItemModel deserializeCartItem(dynamic productJson) {
  return ShopCartItemModel(
      productJson['product_id'],
      productJson['name'],
      productJson['description'],
      productJson['image_url'],
      double.parse(productJson['price'].toString()),
      productJson['quantity']
  );
}

dynamic serializeProduct(ShopCartItemModel product) {
  return {
    'product_id': null,
    'name': product.title,
    'description': product.subtitle,
    'imageURL': product.imageUri,
    'price': product.cost,
    'quantity': product.count
  };
}
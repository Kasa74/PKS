import 'package:flutter/material.dart';

import '../models/ShopCartItemModel.dart';
import '../screens/cart/CartItemCountChanger.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class ShopCartItem extends StatelessWidget {
  final ShopCartItemModel item;
  final VoidCallback onTap;
  final ValueChanged<int> onCountChanged;
  final VoidCallback deleteItem;

  const ShopCartItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.onCountChanged,
    required this.deleteItem
  });

  @override
  Widget build(BuildContext context) {
    return  Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Slidable(

          direction: Axis.horizontal,
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.5,
            children: [
              SlidableAction(
                onPressed: (context) {
                  deleteItem();
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Удалить',
              ),
            ],
          ),

          key: ValueKey(item.id.toString()),
          child: ListTile(
            leading: Image.network(
              item.imageUri,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
            title: Text(item.title),
            subtitle: Text("${item.cost}₽"),
            trailing: CartItemCountChanger(
              count: item.count,
              onIncreasePressed: () {
                onCountChanged(item.count + 1);
              },
              onDecreasePressed: () {
                if (item.count == 1) {
                  deleteItem();
                }
                else {
                  onCountChanged(item.count - 1);
                }
              },
            ),
            onTap: onTap,
          )
      ),
    );
  }
}

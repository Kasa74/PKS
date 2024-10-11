import 'package:flutter/material.dart';
import 'package:untitled/data/Products.dart';
import 'package:untitled/models/CartItem.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/product_card_page.dart';

class CardsListPage extends StatefulWidget {
  const CardsListPage({
    required this.favoriteProducts,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.removeCartItem
  });

  final Set<Product> favoriteProducts;
  final Function(Product) onFavoriteToggle;
  final Function(Product) onAddToCart;
  final Function(CartItem) removeCartItem;



  @override
  _CardsListPageState createState() => _CardsListPageState();
}

class _CardsListPageState extends State<CardsListPage> {
  List<Product> items = List.from(Products.items);

  void _navigateToAddCardScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCardScreen()),
    );

    if (result != null ) {
      setState(() {
        items.add(result);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Товары'),
      ),
      body: items.isEmpty
          ? Center(child: Text('No cards yet, add a card!'))
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.78,
        ),
        padding: EdgeInsets.only(left: 20, right: 20),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return
            GestureDetector(
              onTap: () =>  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductPage(
                item: items[index],
                removeCartItem: widget.removeCartItem,
                onAddToCart: (item) {
                  widget.onAddToCart(item);
                },
                favoriteProducts: widget.favoriteProducts,
                onFavoriteToggle: (item) {
                  setState(() {
                    if(widget.favoriteProducts.contains(item)){
                      widget.favoriteProducts.remove(item);
                    } else {
                      widget.favoriteProducts.add(item);
                    }

                  });
                },
                onDelete: () {
                  setState(() {
                    widget.favoriteProducts.remove(items[index]);
                    items.removeAt(index);
                  });
                  Navigator.pop(context);
                },

                )),
              ),

                child: Container(

                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),),
                  child: Column(
                    children: [
                      Container(
                  height: 160,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            image: DecorationImage(image: NetworkImage(items[index].imgUrl), fit: BoxFit.contain)
                        ),

                        child:

                            Padding(padding: EdgeInsets.only(left: 130),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    widget.onFavoriteToggle(items[index]);
                                  });
                                },
                                icon: Icon(

                                  widget.favoriteProducts.contains(items[index])
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: widget.favoriteProducts.contains(items[index])
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            )

                      ),
                      Container(height: 70, width: 200,

                      decoration: BoxDecoration(
                        color: Color.fromARGB(99, 99, 99, 100 ),
                        borderRadius: BorderRadius.only(

                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[index].price.toStringAsFixed(items[index].price.truncateToDouble() == items[index].price ? 0 : 1) + " " + "₽",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              items[index].title,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                      )
                    ],
                  ),
                ),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddCardScreen(context),
        child: Icon(Icons.add),
        tooltip: 'Add Card',
      ),
    );
  }
}

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController _itemControllerTitle = TextEditingController();
  final TextEditingController _itemControllerDescription = TextEditingController();
  final TextEditingController _itemControllerPrice = TextEditingController();
  final TextEditingController _itemControllerImageURL = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _itemControllerTitle,
              decoration: InputDecoration(
                labelText: 'Enter card Title',
              ),
              maxLines: 1,
            ),
            TextField(
              controller: _itemControllerDescription,
              decoration: InputDecoration(
                labelText: 'Enter card Description',
              ),
              maxLines: 1,
            ),
            TextField(
              controller: _itemControllerPrice,
              decoration: InputDecoration(
                labelText: 'Enter card price',
              ),
              maxLines: 1,
            ),
            TextField(
              controller: _itemControllerImageURL,
              decoration: InputDecoration(
                labelText: 'Enter card image path',
              ),
              maxLines: 1,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(_itemControllerImageURL.text.isNotEmpty && _itemControllerDescription.text.isNotEmpty && _itemControllerPrice.text.isNotEmpty && _itemControllerImageURL.text.isNotEmpty) {
                  Product newCard = Product(id: DateTime.now().millisecondsSinceEpoch, title: _itemControllerTitle.text, description: _itemControllerDescription.text,price: double.tryParse(_itemControllerPrice.text) ?? 0.0, imgUrl: _itemControllerImageURL.text);
                  Navigator.pop(context, newCard);

                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

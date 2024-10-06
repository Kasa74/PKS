import 'package:flutter/material.dart';
import 'package:untitled/data/Products.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/product_card_page.dart';

class CardsListPage extends StatefulWidget {
  const CardsListPage({
    required this.favoriteProducts,
    required this.onFavoriteToggle,
  });

  final Set<Product> favoriteProducts;
  final Function(Product) onFavoriteToggle;



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
        title: Text('Cards'),
      ),
      body: items.isEmpty
          ? Center(child: Text('No cards yet, add a card!'))
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
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

                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(image: NetworkImage(items[index].imgUrl), fit: BoxFit.cover)
                  ),
                  child: Column(
                    children: [
                      Padding(

                        padding: const EdgeInsets.only(),
                        child: Text(items[index].title,style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Padding(padding: EdgeInsets.only(top: 100, right: 120),
                        child: IconButton(
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
  final TextEditingController _noteControllerTitle = TextEditingController();
  final TextEditingController _noteControllerDescription = TextEditingController();
  final TextEditingController _noteControllerImageURL = TextEditingController();

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
              controller: _noteControllerTitle,
              decoration: InputDecoration(
                labelText: 'Enter card Title',
              ),
              maxLines: 1,
            ),
            TextField(
              controller: _noteControllerDescription,
              decoration: InputDecoration(
                labelText: 'Enter card Description',
              ),
              maxLines: 1,
            ),
            TextField(
              controller: _noteControllerImageURL,
              decoration: InputDecoration(
                labelText: 'Enter card image path',
              ),
              maxLines: 1,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(_noteControllerImageURL.text.isNotEmpty && _noteControllerDescription.text.isNotEmpty && _noteControllerImageURL.text.isNotEmpty) {
                  Product newCard = Product(id: DateTime.now().millisecondsSinceEpoch, title: _noteControllerTitle.text, description: _noteControllerDescription.text, imgUrl: _noteControllerImageURL.text);
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

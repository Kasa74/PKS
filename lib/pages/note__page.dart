import 'package:flutter/material.dart';
import 'package:untitled/components/product_card.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/product_card_page.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesListScreen(),
    );
  }
}
//
// class Product {
//   final num id;
//   final String title;
//   final String description;
//   final String imgUrl;
//
//   Product({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.imgUrl
//   });
// }
//
// class Products {
//   static final List<Product> items = [
//   Product(
//   id: 1,
//   title: 'Axe',
//   description: 'As a grunt in the Army of Red Mist, Mogul Khan set his sights on the rank of Red Mist General. In battle after battle he proved his worth through gory deed. His rise through the ranks was helped by the fact that he never hesitated to decapitate a superior.',
//   imgUrl: 'https://cdn.akamai.steamstatic.com/apps/dota2/videos/dota_react/heroes/renders/axe.png'
//   ),
//   Product(
//   id: 2,
//   title: 'Crystal Maiden',
//   description: 'orn in a temperate realm, raised with her fiery older sister Lina, Rylai the Crystal Maiden soon found that her innate elemental affinity to ice created trouble for all those around her.',
//   imgUrl: 'https://cdn.akamai.steamstatic.com/apps/dota2/videos/dota_react/heroes/renders/crystal_maiden.png'
//   ),
//   Product(
//   id: 3,
//   title: 'Juggernaut',
//   description: 'Yurnero the Juggernaut, named after the martial tradition that he swore to preserve and protect, is the last of his masked kind who drowned beneath the waves that deluged the ancient Isle of Masks.',
//   imgUrl: 'https://cdn.akamai.steamstatic.com/apps/dota2/videos/dota_react/heroes/renders/juggernaut.png'
//   )];
// }

class NotesListScreen extends StatefulWidget {
  @override
  _NotesListScreenState createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  List<Product> items = [];

  // Метод для перехода на экран добавления заметки
  void _navigateToAddNoteScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNoteScreen()),
    );

    if (result != null ) {
      setState(() {
        items.add(result);
      });
    }
  }

  void _removeNote(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: items.isEmpty
          ? Center(child: Text('No cards yet, add a card!'))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return
            GestureDetector(
              onTap: () =>  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductPage(item: items[index],)),
              ),
              child: Padding(

                padding: const EdgeInsets.only(left: 100, right: 100, top: 10, bottom: 10),
                child: Container(

                  alignment: Alignment.topCenter,
                  height: 200,
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
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _removeNote(index),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
            ListTile(
            title: Text(items[index].title),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeNote(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddNoteScreen(context),
        child: Icon(Icons.add),
        tooltip: 'Add Note',
      ),
    );
  }
}

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _noteControllerTitle = TextEditingController();
  final TextEditingController _noteControllerDescription = TextEditingController();
  final TextEditingController _noteControllerImageURL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Note'),
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
              maxLines: 5,
            ),
            TextField(
              controller: _noteControllerDescription,
              decoration: InputDecoration(
                labelText: 'Enter card Description',
              ),
              maxLines: 5,
            ),
            TextField(
              controller: _noteControllerImageURL,
              decoration: InputDecoration(
                labelText: 'Enter card image path',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(_noteControllerImageURL.text.isNotEmpty && _noteControllerDescription.text.isNotEmpty && _noteControllerImageURL.text.isNotEmpty) {
                  Product newNote = Product(id: DateTime.now().millisecondsSinceEpoch, title: _noteControllerTitle.text, description: _noteControllerDescription.text, imgUrl: _noteControllerImageURL.text);
                  Navigator.pop(context, newNote);

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

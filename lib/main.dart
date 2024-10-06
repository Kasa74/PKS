import 'package:flutter/material.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/favorite__page.dart';
import 'package:untitled/pages/profile__page.dart';
import 'package:untitled/pages/cardsList__page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final Set<Product> favoriteProducts = {};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(Product product){
setState(() {
  if (favoriteProducts.contains(product)) {
    favoriteProducts.remove(product);
  } else {
    favoriteProducts.add(product);
  }
});
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      CardsListPage(
        favoriteProducts: favoriteProducts,
        onFavoriteToggle: _toggleFavorite,),
      FavoritePage(
        favoriteProducts: favoriteProducts,
        onFavoriteToggle: _toggleFavorite,
      ),
      ProfilePage(),
    ];
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
        label: 'Главная',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Избранное',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Профиль',
        )
      ],
      currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 38, 148, 88),
        onTap: _onItemTapped,
      ),
    );
  }
}

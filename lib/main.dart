import 'package:flutter/material.dart';
import 'package:untitled/models/CartItem.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/pages/cart__page.dart';
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
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[800],
        canvasColor: Colors.grey[850],
        cardColor: Colors.grey[800],
        dialogBackgroundColor: Colors.grey[700],
        dividerColor: Colors.grey[600],
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
  final Set<CartItem> cartItems = {};

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

  void _addToCart(Product product){
    setState(() {

      bool itemExist = false;

      for(CartItem cartItem in cartItems){
        if(cartItem.id == product.id){
          cartItem.count += 1;
          itemExist = true;
          break;
        }
      }

      if (!itemExist) {
        cartItems.add(CartItem(1,
          id: product.id,
          title: product.title,
          description: product.description,
          price: product.price,
          imgUrl: product.imgUrl,
        ));
      }

    });
  }

  void _removeCartItem(CartItem cartItem){
    setState(() {
      cartItems.remove(cartItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      CardsListPage(
        favoriteProducts: favoriteProducts,
        onFavoriteToggle: _toggleFavorite,
        onAddToCart: _addToCart,
        removeCartItem: _removeCartItem,
      ),
      FavoritePage(
        favoriteProducts: favoriteProducts,
        onFavoriteToggle: _toggleFavorite,
        onAddToCart: _addToCart,
        removeCartItem: _removeCartItem,
      ),
      CartPage(
        cartItems: cartItems,
        removeCartItem: _removeCartItem,
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
          icon: Icon(Icons.shopping_cart),
          label: 'Корзина',
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

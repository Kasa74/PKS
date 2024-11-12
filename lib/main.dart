import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/data/cartItemsData.dart';
import 'package:untitled/models/productItem.dart';
import 'package:untitled/pages/CartPage.dart';
import 'package:untitled/pages/HomePage.dart';
import 'package:untitled/pages/ProfilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Клиника',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final Cart cart = Cart();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(cart: cart),
      CartPage(cart: cart),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 88,
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              label: 'Главная',
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/Home.png',
                    color: _selectedIndex == 0 ? Color(0xFF1A6FEE) : Color(0xFF898A8D),
                  ),
                ],
              ),
            ),
            BottomNavigationBarItem(
              label: 'Корзина',
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/Cart.png',
                    color: _selectedIndex == 1 ? Color(0xFF1A6FEE) : Color(0xFF898A8D),
                  ),
                ],
              ),
            ),
            BottomNavigationBarItem(
              label: 'Профиль',
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/profile.png',
                    color: _selectedIndex == 2 ? Color(0xFF1A6FEE) : Color(0xFF898A8D),
                  ),
                ],
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF1A6FEE),
          unselectedItemColor: Color(0xFF898A8D),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

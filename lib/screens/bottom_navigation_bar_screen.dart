import 'package:flutter/material.dart';

import '../screens/products_display_screen.dart';
import '../widgets/app_bar_custom.dart';
import '../resources/ccolor_manager.dart';
import '../screens/test_screen.dart';
import '../screens/shopping_cart_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  late List<Map<String, dynamic>> _pages;
  int _selectPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': ProductDisplayScreen(),
        'title': 'Home',
      },
      {
        'page': ShoppingCartScreen(),
        'title': 'Cart',
      },
      {
        'page': ProductDisplayScreen(),
        'title': 'Favourite',
      },
      {
        'page': TestScreen(),
        'title': 'My Account',
      },
    ];
  }

  void _selectPage(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectPageIndex = index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        showNotification: true,
        title: _pages[_selectPageIndex]['title'],
        notificationCount: 2,
        onBack: () {},
        onNotify: () {},
      ).appBar(),
      body: _pages[_selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'My Account',
          ),
        ],
        onTap: _selectPage,
        currentIndex: _selectPageIndex,
        selectedItemColor: ColorManager.lightGreen,
        unselectedItemColor: ColorManager.lightGrey,
       backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

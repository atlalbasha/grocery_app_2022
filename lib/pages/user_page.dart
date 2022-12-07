import 'package:badges/badges.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/screens/user/category_screen.dart';
import 'package:grocery_app_2022/screens/user/favorites_screen.dart';
import 'package:grocery_app_2022/screens/user/profile/profile_screen.dart';
import 'package:grocery_app_2022/styles/app_layout.dart';
import 'package:grocery_app_2022/styles/styles.dart';
import 'package:unicons/unicons.dart';

import '../controller/cart_controller.dart';
import '../screens/user/cart/cart_screen.dart';
import '../screens/user/home_screen.dart';

class UserPage extends StatefulWidget {
  UserPage({super.key});
  final CartController cartController = Get.put(CartController());

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  static final List<Widget> _screens = [
    HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const FavoritesScreen(),
    ProfileScreen(),
  ];
  int _selectedIndex = 0;
  int count = 0;

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blueGrey.shade900,
        unselectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_search_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_search_filled),
              label: 'Category'),
          BottomNavigationBarItem(
              icon: BadgeIcon(),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Cart'),
          BottomNavigationBarItem(
            icon: Icon(UniconsLine.heart),
            activeIcon: Icon(UniconsLine.heart_alt),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(UniconsLine.user),
            activeIcon: Icon(UniconsLine.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class BadgeIcon extends StatelessWidget {
  BadgeIcon({
    Key? key,
  }) : super(key: key);
  final CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => cartController.products.length > 0
        ? Badge(
            badgeContent: Text(cartController.products.length.toString(),
                style: Styles.headLineStyle4.copyWith(color: Styles.bgColor)),
            child: Icon(Icons.shopping_bag_outlined),
          )
        : Icon(Icons.shopping_bag_outlined));
  }
}

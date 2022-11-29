import 'package:flutter/material.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:grocery_app_2022/screens/user/product/all_products.dart';
import 'package:grocery_app_2022/screens/user/product/fruits.dart';
import 'package:grocery_app_2022/screens/user/product/category_product.dart';

import '../../styles/app_layout.dart';
import '../../styles/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const SearchBar(),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Styles.orangeColor,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'Fruits',
              ),
              Tab(
                text: 'Vegetables',
              ),
              Tab(
                text: 'Drinks',
              ),
              Tab(
                text: 'Bakery',
              ),
              Tab(
                text: 'Other',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllProducts(),
            CategoryProduct(category: 'Fruits'),
            CategoryProduct(category: 'Vegetables'),
            CategoryProduct(category: 'Drinks'),
            CategoryProduct(category: 'Bakery'),
            CategoryProduct(category: 'Other'),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: AppLayout.getHeight(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onChanged: (value) => value,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search...',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.search, color: Styles.orangeColor),
          ),
        ),
      ),
    );
  }
}

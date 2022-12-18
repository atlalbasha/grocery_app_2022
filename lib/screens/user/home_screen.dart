import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:grocery_app_2022/controller/search_controller.dart';
import 'package:grocery_app_2022/screens/user/product/all_products.dart';

import 'package:grocery_app_2022/screens/user/product/category_product.dart';
import 'package:grocery_app_2022/screens/user/product/search_product.dart';

import '../../styles/app_layout.dart';
import '../../styles/styles.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchController searchController = Get.put(SearchController());
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: SearchBar(),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Styles.orangeColor,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Fruits'),
              Tab(text: 'Vegetables'),
              Tab(text: 'Drinks'),
              Tab(text: 'Bakery'),
              Tab(text: 'Other'),
            ],
          ),
        ),
        body: Obx(
          () => TabBarView(
            children: [
              searchController.searchText == ''
                  ? AllProducts()
                  : SearchProduct(),
              searchController.searchText == ''
                  ? CategoryProduct(category: 'Fruits')
                  : SearchProduct(),
              searchController.searchText == ''
                  ? CategoryProduct(category: 'Vegetables')
                  : SearchProduct(),
              searchController.searchText == ''
                  ? CategoryProduct(category: 'Drinks')
                  : SearchProduct(),
              searchController.searchText == ''
                  ? CategoryProduct(category: 'Bakery')
                  : SearchProduct(),
              searchController.searchText == ''
                  ? CategoryProduct(category: 'Other')
                  : SearchProduct(),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
  }) : super(key: key);
  SearchController searchController = Get.put(SearchController());
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
        onChanged: (value) => {
          searchController.searchText = value,
        },
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

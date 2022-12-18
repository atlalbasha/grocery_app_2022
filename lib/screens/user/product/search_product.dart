import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/controller/search_controller.dart';
import 'package:grocery_app_2022/screens/user/product/product_card.dart';

import '../../../styles/styles.dart';

class SearchProduct extends StatelessWidget {
  SearchProduct({super.key});
  SearchController searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        (() => Padding(
              padding: const EdgeInsets.all(20),
              child: searchController.products.isNotEmpty
                  ? GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 1.3,
                      children: List.generate(
                        searchController.products.length,
                        (index) {
                          return ProductCard(
                            product: searchController.products[index],
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text('No Products', style: Styles.headLineStyle3),
                    ),
            )),
      ),
    );
  }
}

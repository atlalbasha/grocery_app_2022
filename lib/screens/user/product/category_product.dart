import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/screens/user/product/product_card.dart';

import '../../../controller/product_controller.dart';
import '../../../styles/styles.dart';
import '../../../controller/cart_controller.dart';

class CategoryProduct extends StatelessWidget {
  CategoryProduct({super.key, required this.category});
  final String category;
  final cartController = Get.put(CartController());
  final productController = Get.put(ProductController());

  getCategory() {
    return productController.products
                .where((i) => i.category == category)
                .toList()
                .length >
            0
        ? productController.products
            .where((i) => i.category == category)
            .toList()
        : [];
  }

  void inintState() {
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        (() => Padding(
              padding: const EdgeInsets.all(20),
              child: getCategory().length != 0
                  ? GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 1.3,
                      children: List.generate(getCategory().length, (index) {
                        return ProductCard(
                          product: getCategory()[index],
                        );
                      }),
                    )
                  : Center(
                      child: Text('No Products', style: Styles.headLineStyle3),
                    ),
            )),
      ),
    );
  }
}

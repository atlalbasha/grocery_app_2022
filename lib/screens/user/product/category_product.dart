import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/controller/category_controller.dart';
import 'package:grocery_app_2022/screens/user/product/product_card.dart';

import '../../../controller/product_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../styles/styles.dart';
import '../../../controller/cart_controller.dart';

class CategoryProduct extends StatelessWidget {
  CategoryProduct({super.key, required this.category});
  final String category;

  CategoryController categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    categoryController.getProductsByCategory(category);
    return Scaffold(
      body: Obx(
        (() => Padding(
              padding: const EdgeInsets.all(20),
              child: categoryController.products.isNotEmpty
                  ? GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 1.3,
                      children: List.generate(
                        categoryController.products.length,
                        (index) {
                          return ProductCard(
                            product: categoryController.products[index],
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

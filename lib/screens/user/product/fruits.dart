import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/screens/user/product/product_card.dart';

import '../../../controller/product_controller.dart';
import '../../../controller/cart_controller.dart';

class Fruits extends StatelessWidget {
  Fruits({super.key, required this.category});
  final String category;
  final cartController = Get.put(CartController());
  final productController = Get.put(ProductController());



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Obx(
        (() => Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1 / 1.3,
                children: List.generate(
                  productController.products.length,
                  (index) {
                    if (productController.products[index].category ==
                        category) {
                      return ProductCard(
                        product: productController.products[index],
                      );
                    }
                    return Container();
                  },
                ),
              ),
            )),
      ),
    );
  }
}

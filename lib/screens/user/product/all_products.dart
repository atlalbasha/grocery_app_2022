import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:grocery_app_2022/screens/user/product/product_card.dart';
import 'package:grocery_app_2022/styles/styles.dart';
import '../../../controller/product_controller.dart';
import '../../../controller/cart_controller.dart';
import '/models/product.dart';

class AllProducts extends StatelessWidget {
  AllProducts({
    super.key,
  });

  CartController cartController = Get.find();
  ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        (() => Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: productController.products.isNotEmpty
                  ? GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 1.3,
                      children: List.generate(
                        productController.products.length,
                        (index) {
                          return ProductCard(
                            product: productController.products[index],
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

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/controller/cart_controller.dart';
import 'package:grocery_app_2022/styles/app_layout.dart';

import '../../../../models/product.dart';
import '../../../../styles/styles.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      product.imageUrl,
                      height: AppLayout.getHeight(50),
                      width: AppLayout.getWidth(50),
                    ),
                    const Gap(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: Styles.headLineStyle2,
                        ),
                        const Gap(6),
                        Text(
                          product.discount.isGreaterThan(0)
                              ? '${(product.price - (product.price * product.discount / 100)).toStringAsFixed(2)}\$'
                              : '${product.price.toStringAsFixed(2)}\$',
                          style: Styles.headLineStyle4,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      cartController.removeProduct(product);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Styles.orangeColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Styles.whiteColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Obx(
                      () => Text(
                        product.quantity.toString(),
                        style: Styles.headLineStyle2,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cartController.addProduct(product);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Styles.orangeColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

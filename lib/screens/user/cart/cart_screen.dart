import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/controller/cart_controller.dart';
import 'package:grocery_app_2022/screens/user/cart/payment_cart.dart';
import 'package:grocery_app_2022/screens/user/profile/payment.dart';

import '../../../models/product.dart';
import '../../../styles/app_layout.dart';
import '../../../styles/styles.dart';
import 'components/cart_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Scaffold(
        body: Obx(
      () => cartController.products.length > 0
          ? Column(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 1,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 20,
                        childAspectRatio: 4,
                        children: List.generate(
                          cartController.products.length,
                          (index) {
                            return CartCard(
                              product: cartController.products[index],
                            );
                          },
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total: ', style: Styles.textStyle),
                            Text(cartController.total.toString(),
                                style: Styles.headLineStyle4),
                          ],
                        ),
                        Divider(color: Styles.primaryColor),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal: ', style: Styles.textStyle),
                            Text(cartController.subTotal.toString(),
                                style: Styles.headLineStyle4),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Shipping fee: ', style: Styles.textStyle),
                            Text(cartController.shippingFee.toString(),
                                style: Styles.headLineStyle4),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => PaymentCart());
                      },
                      child: Text('Checkout'),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
              "No items in cart",
              style: Styles.headLineStyle3,
            )),
    ));
  }
}

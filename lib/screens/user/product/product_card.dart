import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/controller/product_controller.dart';
import 'package:grocery_app_2022/models/product.dart';
import 'package:grocery_app_2022/controller/cart_controller.dart';
import 'package:grocery_app_2022/screens/admin/upload_product_screen.dart';
import 'package:grocery_app_2022/screens/user/product/product_details_screen.dart';
import 'package:grocery_app_2022/styles/app_layout.dart';

import '../../../controller/user_controller.dart';
import '../../../styles/styles.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  CartController cartController = Get.find();
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    print(userController.myUser.isAdmin);
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetails(product: product));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: AppLayout.getHeight(100),
                    width: AppLayout.getHeight(200),
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: product,
                      child: Image.network(product.imageUrl),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    product.discount != 0
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${product.discount} %',
                              style: Styles.headLineStyle4
                                  .copyWith(color: Colors.white),
                            ),
                          )
                        : const SizedBox(),
                    InkWell(
                      onTap: () {
                        print('object');
                      },
                      child: Icon(
                        Icons.favorite_border,
                        color: Styles.orangeColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(10),
            Text(
              product.title,
              style: Styles.textStyle,
              maxLines: 2,
            ),
            Text(product.unit, style: Styles.headLineStyle4),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${product.price.toString()}\$',
                      style: Styles.headLineStyle4.copyWith(
                          decoration: product.discount.isGreaterThan(0)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: Styles.orangeColor),
                    ),
                    const Gap(4),
                    Text(
                      product.discount.isGreaterThan(0)
                          ? '${(product.price - (product.price * product.discount / 100)).toStringAsFixed(2)}\$'
                          : '',
                      style: Styles.headLineStyle4,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => {
                    userController.myUser.isAdmin == true
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UploadProductScreen(
                                  product: product,
                                )))
                        : cartController.addProduct(product),
                  },
                  child: Container(
                    height: AppLayout.getHeight(30),
                    width: AppLayout.getWidth(30),
                    decoration: BoxDecoration(
                      color: Styles.orangeColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: userController.myUser.isAdmin == true
                        ? const Icon(Icons.edit, color: Colors.white)
                        : const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

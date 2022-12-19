import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:grocery_app_2022/controller/cart_controller.dart';
import 'package:grocery_app_2022/controller/favorite_controller.dart';
import 'package:grocery_app_2022/screens/user/product/product_card.dart';

import '../../styles/styles.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        (() => favoriteController.favorites.isEmpty
            ? Center(
                child: Text(
                "No products in favorites",
                style: Styles.headLineStyle3,
              ))
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 1.3,
                      children: List.generate(
                        favoriteController.favorites.length,
                        (index) {
                          return ProductCard(
                            product: favoriteController.favorites[index],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )),
      ),
    );
  }
}

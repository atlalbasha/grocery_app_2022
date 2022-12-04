import 'dart:convert';

import 'package:get/get.dart';
import 'package:grocery_app_2022/models/product.dart';

import '../models/cart.dart';
import '../styles/styles.dart';

class CartController extends GetxController {
  final _cart = <Cart>[].obs;
  List<Map<String, dynamic>> get myCart => _cart.map((e) => e.toMap()).toList();
  final dynamic _products = [].obs;
  var shippingFee = 20.00;

  get products => _products;

  void addProduct(Product product) {
    int quantity = 1;
    Cart newCart = Cart();
    if (_products.contains(product)) {
      product.quantity++;
      quantity++;
      _cart.forEach((element) {
        if (element.product!['id'] == product.id) {
          element.quantity = element.quantity! + 1;
        }
      });
    } else {
      _products.add(product);
      newCart = Cart(product: product.toMap(), quantity: quantity);
      _cart.add(newCart);
    }

    if (product.quantity.value > 1) return;
    Get.snackbar(
      'Added to cart',
      '${product.title} added to cart',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Styles.orangeColor,
      colorText: Styles.whiteColor,
      duration: const Duration(seconds: 1),
    );
  }

  void removeProduct(Product product) {
    if (_products.contains(product)) {
      product.quantity.value--;
      _cart.forEach((element) {
        if (element.product!['id'] == product.id) {
          element.quantity = element.quantity! - 1;
        }
      });
    }
    if (product.quantity.value < 1) {
      _products.remove(product);
      Get.snackbar(
        'Removed from cart',
        '${product.title} removed from cart',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Styles.orangeColor,
        colorText: Styles.whiteColor,
        duration: const Duration(seconds: 1),
      );
    }
  }

  get subTotal => _products
      .map((e) => (e.price - (e.price * e.discount / 100)) * e.quantity.value)
      .reduce((a, b) => a + b)
      .toStringAsFixed(2);

  get total {
    var total = _products
            .map((e) =>
                (e.price - (e.price * e.discount / 100)) * e.quantity.value)
            .reduce((a, b) => a + b) +
        shippingFee;
    return total.toStringAsFixed(2);
  }
}

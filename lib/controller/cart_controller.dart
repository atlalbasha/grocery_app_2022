import 'dart:convert';

import 'package:get/get.dart';
import 'package:grocery_app_2022/models/product.dart';

import '../models/cart.dart';
import '../services/firestore_db.dart';
import '../styles/styles.dart';

class CartController extends GetxController {
  final _cart = <Cart>[].obs;
  List<Map<String, dynamic>> get myCart => _cart.map((e) => e.toMap()).toList();
  final dynamic _products = [].obs;
  var shippingFee = 20.00;

  final products = <Product>[].obs;
  List<Product> get cartList => products;

  @override
  void onReady() {
    products.bindStream(FirestoreDB().getCart());
  }

  Future addProduct(Product product) async {
    await FirestoreDB().addToCart(product);

    if (product.quantity! > 1) return;
    Get.snackbar(
      'Added to cart',
      '${product.title} added to cart',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Styles.orangeColor,
      colorText: Styles.whiteColor,
      duration: const Duration(seconds: 1),
    );
  }

  Future removeProduct(Product product) async {
    await FirestoreDB().deleteFromCart(product);

    if (product.quantity! < 1) {
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

  get subTotal => cartList
      .map((e) => (e.price - (e.price * e.discount / 100)) * e.quantity!)
      .reduce((a, b) => a + b)
      .toStringAsFixed(2);

  get total {
    var total = cartList
            .map((e) => (e.price - (e.price * e.discount / 100)) * e.quantity!)
            .reduce((a, b) => a + b) +
        shippingFee;
    return total.toStringAsFixed(2);
  }
}

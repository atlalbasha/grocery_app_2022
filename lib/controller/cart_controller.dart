import 'package:get/get.dart';
import 'package:grocery_app_2022/models/product.dart';

import '../styles/styles.dart';

class CartController extends GetxController {
  final dynamic _products = [].obs;
  var count = 0.obs;
  increment() => count++;

  void addProduct(Product product) {
    print(product.discount / 10);
    if (_products.contains(product)) {
      product.quantity.value++;
    } else {
      product.quantity.value = 1;
      _products.add(product);
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

  var shippingFee = 20.00;

  get products => _products;

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

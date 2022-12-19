import 'package:get/get.dart';

import '../models/product.dart';
import '../services/firestore_db.dart';
import '../styles/styles.dart';

class FavoriteController extends GetxController {
  final _favorites = <Product>[].obs;
  List<Product> get favorites => _favorites;

  @override
  void onReady() {
    _favorites.bindStream(FirestoreDB().getFavorites());
  }

  Future getFavorites() async {
    _favorites.bindStream(FirestoreDB().getFavorites());
    print('getFavorites: ${favorites.length}');
  }

  Future addToFavorite(Product product) async {
    await FirestoreDB().addToFavorite(product);

    isFavorite(product)
        ? Get.snackbar(
            'Removed from favorite',
            '${product.title} removed from favorite',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Styles.orangeColor,
            colorText: Styles.whiteColor,
            duration: const Duration(seconds: 1),
          )
        : Get.snackbar(
            'Added to favorite',
            '${product.title} added to favorite',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Styles.orangeColor,
            colorText: Styles.whiteColor,
            duration: const Duration(seconds: 1),
          );
  }

  bool isFavorite(Product product) {
    bool isFavorite = false;
    favorites.forEach((element) {
      if (element.id == product.id) isFavorite = true;
    });
    return isFavorite;
  }
}

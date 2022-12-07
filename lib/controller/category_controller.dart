import 'package:get/get.dart';

import '../models/product.dart';
import '../services/firestore_db.dart';

class CategoryController extends GetxController {
  final _category = ''.obs;
  set category(String value) => _category.value = value;
  String get category => _category.value;

  var products = <Product>[].obs;
  List<Product> get productList => products;

  @override
  void onClose() {
    _category.value = '';
    super.onClose();
  }

  @override
  void onReady() {
    products.bindStream(FirestoreDB().getProductsByCategory(category));

    super.onReady();
  }

  Future getProductsByCategory(String category) async {
    products.bindStream(FirestoreDB().getProductsByCategory(category));
  }
}

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../models/product.dart';
import '../services/firestore_db.dart';

class ProductController extends GetxController {
  final products = <Product>[].obs;
  var newProduct = {}.obs;

  List<String> category = ['Fruits', 'Vegetables', 'Drinks', 'Other'];
  String? selectedCategory = 'Fruits';

  List<String> units = ['1kg', '1pcs'];
  String? selectedUnits = '1kg';

  

  // final _isLoading = false.obs;
  // final _isError = false.obs;
  // final _errorMessage = ''.obs;

  List<Product> get productList => products;
  // bool get isLoading => _isLoading.value;
  // bool get isError => _isError.value;
  // String get errorMessage => _errorMessage.value;

  @override
  void onReady() {
    products.bindStream(FirestoreDB().getAllProducts());
  }

  void updateProuctPrice(Product product, double price) {
    product.price = price;
  }

  // void _getProducts() async {
  //   _isLoading.value = true;
  //   try {
  //     products.value =  FirestoreDB().getAllProducts();
  //   } catch (e) {
  //     _isError.value = true;
  //     _errorMessage.value = e.toString();
  //   } finally {
  //     _isLoading.value = false;
  //   }
  // }
}

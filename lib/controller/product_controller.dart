import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/controller/image_controller.dart';

import '../models/product.dart';
import '../services/firestore_db.dart';
import '../styles/styles.dart';

class ProductController extends GetxController {
  ImageController imageController = Get.put(ImageController());
  final _isLoading = false.obs;
  final _isError = false.obs;
  final _errorMessage = ''.obs;
  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
  String get errorMessage => _errorMessage.value;
  final formKey = GlobalKey<FormState>();
  final products = <Product>[].obs;
  List<Product> get productList => products;
  var newProduct = {}.obs;

  List<String> category = ['Fruits', 'Vegetables', 'Drinks', 'Other'];
  String? selectedCategory = 'Fruits';

  List<String> units = ['1kg', '1pcs'];
  String? selectedUnits = '1kg';

  @override
  void onReady() {
    products.bindStream(FirestoreDB().getAllProducts());
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateProuctPrice(Product product, double price) {
    product.price = price;
  }

  Future uploadProduct() async {
    _isLoading.value = true;

    try {
      if (formKey.currentState!.validate()) {
        Product product = Product(
          id: '',
          title: newProduct['Title'],
          price: double.parse(newProduct['Price']),
          category: newProduct['Category'],
          description: newProduct['Description'],
          discount: int.parse(newProduct['Discount']),
          imageUrl: imageController.imagePath,
          unit: newProduct['Unit'],
        );
        await FirestoreDB().addProduct(product: product);
      }
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future updateProduct(Product product) async {
    _isLoading.value = true;

    try {
      Product updateProduct = Product(
          id: product.id,
          title:
              newProduct['Title'] == null ? product.title : newProduct['Title'],
          price: newProduct['Price'] == null
              ? product.price
              : double.parse(newProduct['Price']),
          category: newProduct['Category'] == null
              ? product.category
              : newProduct['Category'],
          description: newProduct['Description'] == null
              ? product.description
              : newProduct['Description'],
          discount: newProduct['Discount'] == null
              ? product.discount
              : int.parse(newProduct['Discount']),
          imageUrl: imageController.image == null
              ? product.imageUrl
              : imageController.imagePath,
          unit: newProduct['Unit'] == null ? product.unit : newProduct['Unit']);

      await FirestoreDB().updateProduct(updateProduct);
      newProduct = {}.obs;
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;

      Get.snackbar(
        'Updated product',
        'product is updated successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Styles.orangeColor,
        colorText: Styles.whiteColor,
        duration: const Duration(seconds: 1),
      );
    }
  }

  Future deleteProduct(String id) async {
    _isLoading.value = true;
    try {
      await FirestoreDB().deleteProduct(id);
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
      Get.snackbar(
        'Deleted product',
        'product is deleted successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Styles.orangeColor,
        colorText: Styles.whiteColor,
        duration: const Duration(seconds: 1),
      );
    }
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

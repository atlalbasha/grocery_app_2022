import 'package:get/get.dart';
import 'package:grocery_app_2022/controller/cart_controller.dart';
import 'package:grocery_app_2022/controller/category_controller.dart';
import 'package:grocery_app_2022/controller/image_controller.dart';
import 'package:grocery_app_2022/controller/order_controller.dart';
import 'package:grocery_app_2022/controller/search_controller.dart';
import 'package:grocery_app_2022/controller/user_controller.dart';

import '../controller/product_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => CategoryController(), fenix: true);
    Get.lazyPut(() => ImageController(), fenix: true);
    Get.lazyPut(() => ProductController(), fenix: true);
    Get.lazyPut(() => OrderController(), fenix: true);
    Get.put(() => UserController());
    Get.lazyPut(() => SearchController(), fenix: true);
  }
}

import 'package:get/get.dart';

import '../models/order.dart';
import '../services/firestore_db.dart';
import '../styles/styles.dart';

class OrderController extends GetxController {
  final _isLoading = false.obs;
  final _isError = false.obs;
  final _errorMessage = ''.obs;
  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
  String get errorMessage => _errorMessage.value;

  var isOpen = false.obs;

  final orders = <Order>[].obs;
  List<Order> get productList => orders;

  final newOrders = {}.obs;
  //List<Order> get orderList => orders;
  @override
  void onReady() {
    orders.bindStream(FirestoreDB().getOrdersByStatus('Pending'));
  }

  Future getOrdersByStatus(String status) async {
    orders.bindStream(FirestoreDB().getOrdersByStatus(status));
  }

  Future deleteOrder(String id) async {
    _isLoading.value = true;
    try {
      FirestoreDB().deleteOrder(id);
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
      Get.snackbar(
        'Deleted order',
        'order is deleted successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Styles.orangeColor,
        colorText: Styles.whiteColor,
        duration: const Duration(seconds: 1),
      );
    }
  }

  Future updateOrder(Order order) async {
    _isLoading.value = true;
    try {
      Order newOrder = Order(
        id: order.id,
        cart: order.cart,
        user: order.user,
        total: order.total,
        status: order.status == 'preparing' ? 'shipping' : 'delivered',
        date: order.date,
        paymentMethod: order.paymentMethod,
        paymentStatus: 'pending',
        deliveryStatus: 'Pending',
      );
      FirestoreDB().updateOrder(newOrder);
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
      Get.snackbar(
        'Updated order',
        'order is updated successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Styles.orangeColor,
        colorText: Styles.whiteColor,
        duration: const Duration(seconds: 1),
      );
    }
  }

  Future addOrder(Order order) async {
    _isLoading.value = true;
    try {
      FirestoreDB().addOrder(order: order);
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
      Get.snackbar(
        'Added order',
        'order is added successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Styles.orangeColor,
        colorText: Styles.whiteColor,
        duration: const Duration(seconds: 1),
      );
    }
  }
}

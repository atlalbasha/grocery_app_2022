import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/models/cart.dart';
import 'package:grocery_app_2022/models/product.dart';
import 'package:grocery_app_2022/models/product.dart';
import 'package:grocery_app_2022/models/user.dart';

class Order {
  late String? id;
  late List<dynamic>? cart;
  late List<Product>? x;
  late Map<String, dynamic>? user;
  late double? total;
  late String? status;
  late String? date;

  late String? paymentMethod;
  late String? paymentStatus;
  late String? deliveryStatus;

  Order({
    this.id,
    this.cart,
    this.user,
    this.total,
    this.status,
    this.date,
    this.paymentMethod,
    this.paymentStatus,
    this.deliveryStatus,
  });
  Order.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    id = snapshot.id;
    cart = snapshot['products'].cast<Map<String, dynamic>>();
    user = snapshot['user'];
    total = snapshot['total'];
    status = snapshot['status'];
    date = snapshot['date'];
    paymentMethod = snapshot['paymentMethod'];
    paymentStatus = snapshot['paymentStatus'];
    deliveryStatus = snapshot['deliveryStatus'];
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'products': cart,
        'user': user,
        'total': total,
        'status': status,
        'date': date,
        'paymentMethod': paymentMethod,
        'paymentStatus': paymentStatus,
        'deliveryStatus': deliveryStatus,
      };
}

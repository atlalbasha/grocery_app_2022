import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/models/cart.dart';
import 'package:grocery_app_2022/models/product.dart';
import 'package:grocery_app_2022/models/product.dart';
import 'package:grocery_app_2022/models/user.dart';

class Order {
  late String? id;
  late List<Map<String, dynamic>>? cart;
  late Map<String, dynamic>? user;
  late double? total;

  Order({
    this.id,
    this.cart,
    this.user,
    this.total,
  });
  Order.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    id = snapshot.id;
    cart = snapshot['products'];
    user = snapshot['user'];
    total = snapshot['total'];
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'products': cart,
        'user': user,
        'total': total,
      };
}

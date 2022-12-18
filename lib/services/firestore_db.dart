import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/models/product.dart';

import '../controller/user_controller.dart';
import '../models/order.dart';
import '../models/user.dart';
import '../styles/styles.dart';

class FirestoreDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = Get.find();

  Stream<List<Product>> getAllProducts() {
    return _firestore
        .collection('products')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Product> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Product.fromDocumentSnapshot(snapshot: element));
      });

      return retVal;
    });
  }

  Stream<List<Product>> getProductsByCategory(String category) {
    return _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Product> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Product.fromDocumentSnapshot(snapshot: element));
      });
      return retVal;
    });
  }

  Stream<List<Product>> searchProduct(String searchText) {
    return _firestore
        .collection('products')
        .where('title', isEqualTo: searchText)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Product> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Product.fromDocumentSnapshot(snapshot: element));
      });

      return retVal;
    });
  }

  Future<void> addProduct({required Product product}) async {
    final productDoc = _firestore.collection('products').doc();
    Product newProduct = Product(
      id: productDoc.id,
      title: product.title,
      price: product.price,
      imageUrl: product.imageUrl,
      description: product.description,
      category: product.category,
      discount: product.discount,
      unit: product.unit,
      quantity: product.quantity,
      availableInStock: product.availableInStock,
    );

    await productDoc.set(newProduct.toMap());
    Get.snackbar(
      'Added product',
      'product is added successfully!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Styles.orangeColor,
      colorText: Styles.whiteColor,
      duration: const Duration(seconds: 1),
    );
  }

  Future<void> updateProduct(Product product) async {
    return await _firestore
        .collection('products')
        .doc(product.id)
        .update(product.toMap());
  }

  Future<void> deleteProduct(String id) async {
    await _firestore.collection('products').doc(id).delete();
  }

// Orders

  Future<void> deleteOrder(String id) async {
    await _firestore.collection('orders').doc(id).delete();
  }

  Stream<List<Order>> getOrdersByStatus(String status) {
    return _firestore
        .collection('orders')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Order> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Order.fromDocumentSnapshot(snapshot: element));
      });
      return retVal;
    });
  }

  Future<void> updateOrder(Order order) async {
    return await _firestore
        .collection('orders')
        .doc(order.id)
        .update(order.toMap());
  }

  Future<void> addOrder({required Order order}) async {
    var cartList = order.cart!.map((c) => c).toList();
    final orderDoc = _firestore.collection('orders').doc();
    Order newOrder = Order(
      id: orderDoc.id,
      cart: order.cart,
      total: order.total,
      user: order.user,
      date: order.date,
      status: order.status,
      paymentMethod: order.paymentMethod,
      paymentStatus: order.paymentStatus,
      deliveryStatus: order.deliveryStatus,
    );

    await orderDoc.set(newOrder.toMap());
  }

  Stream<List<Order>> getAllOrders() {
    return _firestore
        .collection('orders')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Order> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Order.fromDocumentSnapshot(snapshot: element));
      });

      return retVal;
    });
  }

//  Cart
  Future<void> addToCart(Product product) async {
    String uid = _userController.myUser.uid.toString();
    CollectionReference userDoc =
        FirebaseFirestore.instance.collection('users');
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(product.id)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          documentSnapshot['quantity'];
          dynamic data = documentSnapshot.data();

          userDoc
              .doc(uid)
              .collection('cart')
              .doc(product.id)
              .update({'quantity': data['quantity'] = data['quantity'] + 1})
              .then((value) => print("User Updated"))
              .catchError((error) => print("Failed to update user: $error"));

          // print('Document data: ${documentSnapshot.data()}');
        } else {
          userDoc
              .doc(uid)
              .collection('cart')
              .doc(product.id)
              .set(product.toMap());
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFromCart(product) async {
    String uid = _userController.myUser.uid.toString();
    CollectionReference userDoc =
        FirebaseFirestore.instance.collection('users');
    try {
      final QuerySnapshot qSnap =
          await userDoc.doc(uid).collection('cart').get();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(product.id)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          documentSnapshot['quantity'];
          dynamic data = documentSnapshot.data();
          if (data['quantity'] == 0) {
            userDoc.doc(uid).collection('cart').doc(product.id).delete();
          } else {
            userDoc
                .doc(uid)
                .collection('cart')
                .doc(product.id)
                .update({'quantity': data['quantity'] = data['quantity'] - 1})
                .then((value) => print("User Updated"))
                .catchError((error) => print("Failed to update user: $error"));

            // print('Document data: ${documentSnapshot.data()}');

          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<List<Product>> getCart() {
    String uid = _userController.myUser.uid.toString();

    return _firestore
        .collection('users')
        .doc('XIo426ovBveVxchrR03vPn9WlUA2')
        .collection('cart')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Product> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Product.fromDocumentSnapshot(snapshot: element));
      });
      return retVal;
    });
  }
  // Future<void> addNewUser(User user) async {
  // await _firestore
  //     .collection('users').doc(user.id).setData(user.toMap());
  // }

  // Future<void> updateUser(User user) async {
  //   await _db.collection('users').document(user.id).updateData(user.toMap());
  // }

  // Future<void> deleteUser(User user) async {
  //   await _db.collection('users').document(user.id).delete();
  // }

  // Future<User> getUser(String id) async {
  //   var snapshot = await _db.collection('users').document(id).get();
  //   return User.fromMap(snapshot.data);
  // }

  // Future<List<User>> getAllUsers() async {
  //   var snapshot = await _db.collection('users').getDocuments();
  //   return snapshot.documents.map((doc) => User.fromMap(doc.data)).toList();
  // }
}

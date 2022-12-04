import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Product {
  late String? id;
  late String title;
  late double price;
  late int discount;
  late String category;
  late String unit;
  late String description;
  late String imageUrl;

  Product({
    this.id,
    required this.title,
    required this.price,
    required this.discount,
    required this.category,
    required this.unit,
    required this.description,
    required this.imageUrl,
  });
  RxInt quantity = 1.obs;

  Product.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    id = snapshot.id;
    title = snapshot['title'];
    price = snapshot['price'];
    discount = snapshot['discount'];
    category = snapshot['category'];
    unit = snapshot['unit'];
    description = snapshot['description'];
    imageUrl = snapshot['imageUrl'];
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'price': price,
        'discount': discount,
        'category': category,
        'unit': unit,
        'description': description,
        'imageUrl': imageUrl,
      };

  // static Product fromSnapshot(DocumentSnapshot documentSnapshot) {
  //   Product product = Product(
  //       quantity: documentSnapshot['quantity'],
  //       title: documentSnapshot['title'],
  //       price: documentSnapshot['price'],
  //       discount: documentSnapshot['discount'],
  //       category: documentSnapshot['category'],
  //       unit: documentSnapshot['unit'],
  //       description: documentSnapshot['description'],
  //       imageUrl: documentSnapshot['imageUrl']);
  //   return product;
  // }
}



  // static Product formJson(Map<String, dynamic> json) => Product(
  //     id: json['uid'],
  //     title: json['title'],
  //     price: json['price'],
  //     discount: json['discount'],
  //     category: json['category'],
  //     unit: json['unit'],
  //     description: json['description'],
  //     imageUrl: json['imageUrl'],
  //     quantity: json['quantity']);



  // static List<Product> products = [
  //   Product(
  //       id: '1',
  //       title: 'Apple',
  //       price: 100,
  //       discount: 10,
  //       category: 'Fruits',
  //       unit: '1kg',
  //       description: 'Fresh Apple',
  //       imageUrl: 'http://clipart-library.com/images/8TEbenojc.jpg'),
  //   Product(
  //       id: '2',
  //       title: 'Banana',
  //       price: 50,
  //       discount: 5,
  //       category: 'Fruits',
  //       unit: '1kg',
  //       description: 'Fresh Banana',
  //       imageUrl: 'http://clipart-library.com/images/8TAbqxzpc.jpg'),
  //   Product(
  //       id: '3',
  //       title: 'Orange',
  //       price: 100,
  //       discount: 10,
  //       category: 'Fruits',
  //       unit: '1kg',
  //       description: 'Fresh Orange',
  //       imageUrl:
  //           'http://clipart-library.com/image_gallery2/Orange-PNG-Picture.png'),
  // ];

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/controller/cart_controller.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final CartController c = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Test(c: c)),
          FloatingActionButton(child: Icon(Icons.add), onPressed: c.increment),
        ],
      ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({
    Key? key,
    required this.c,
  }) : super(key: key);

  final CartController c;

  @override
  Widget build(BuildContext context) {
    return Text("Clicks: ${c.count}");
  }
}

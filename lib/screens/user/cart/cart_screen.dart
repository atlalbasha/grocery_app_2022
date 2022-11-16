import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grocery_app_2022/screens/user/cart/payment_cart.dart';
import 'package:grocery_app_2022/screens/user/profile/payment.dart';

import '../../../styles/app_layout.dart';
import '../../../styles/styles.dart';
import 'components/cart_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                crossAxisCount: 1,
                mainAxisSpacing: 4,
                crossAxisSpacing: 20,
                childAspectRatio: 4,
                children: [
                  CartCard(),
                  CartCard(),
                  CartCard(),
                  CartCard(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: AppLayout.getHeight(50),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => PaymentCart()))),
                  child: Text('Check Out'),
                ),
              ),
            ),
            Gap(20),
          ],
        ),
      ),
    );
  }
}

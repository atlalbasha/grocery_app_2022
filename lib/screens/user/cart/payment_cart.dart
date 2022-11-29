import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:grocery_app_2022/styles/styles.dart';
import 'package:unicons/unicons.dart';

import '../../../styles/app_layout.dart';

class PaymentCart extends StatefulWidget {
  const PaymentCart({super.key});

  @override
  State<PaymentCart> createState() => _PaymentState();
}

class _PaymentState extends State<PaymentCart> {
  int selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(children: [
        const Gap(20),
        Text('Payment ',
            style: Styles.headLineStyle2, textAlign: TextAlign.center),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Text('Payment method', style: Styles.headLineStyle3),
              const Gap(10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total: ', style: Styles.textStyle),
                          Text('220 USD ', style: Styles.headLineStyle4),
                        ],
                      ),
                      Divider(color: Styles.primaryColor),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total order: ', style: Styles.textStyle),
                          Text('200 USD ', style: Styles.headLineStyle4),
                        ],
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Shipping fee: ', style: Styles.textStyle),
                          Text('20 USD ', style: Styles.headLineStyle4),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(60),
              Text('Payment method', style: Styles.headLineStyle3),
              const Gap(10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    RadioListTile(
                      activeColor: Styles.orangeColor,
                      value: 1,
                      groupValue: selectedValue,
                      title: Text('Pay via card', style: Styles.textStyle),
                      subtitle: Text('Visa or master card',
                          style: Styles.headLineStyle4),
                      onChanged: (value) =>
                          setState(() => selectedValue = value!),
                      secondary: Icon(UniconsLine.credit_card,
                          color: Styles.secondaryColor),
                    ),
                    RadioListTile(
                      activeColor: Styles.orangeColor,
                      value: 2,
                      groupValue: selectedValue,
                      title: Text('Cash on delivery', style: Styles.textStyle),
                      subtitle: Text('Pay cash at home',
                          style: Styles.headLineStyle4),
                      onChanged: (value) =>
                          setState(() => selectedValue = value!),
                      secondary:
                          Icon(UniconsLine.bill, color: Styles.secondaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => PaymentCart());
              },
              child: const Text('Confirm payment'),
            ),
          ),
        ),
        const Gap(10),
      ]),
    );
  }
}

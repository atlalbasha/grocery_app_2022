import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:grocery_app_2022/screens/admin/orders_status.dart';

import '../../styles/app_layout.dart';
import '../../styles/styles.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Orders Status', style: Styles.headLineStyle3),
              Gap(AppLayout.getHeight(10)),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TabBar(
                  indicatorColor: Styles.orangeColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Styles.primaryColor,
                  tabs: const [
                    Tab(text: 'Preparing'),
                    Tab(text: 'Shipping'),
                    Tab(text: 'Delivered'),
                  ],
                ),
              ),
              const Expanded(
                  child: TabBarView(
                children: [
                  OrdersStatus(status: 'preparing'),
                  OrdersStatus(status: 'shipping'),
                  OrdersStatus(status: 'delivered'),
                ],
              ))
            ],
          ),
        )),
      ),
    );
  }
}

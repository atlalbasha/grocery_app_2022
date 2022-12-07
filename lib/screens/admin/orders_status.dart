import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:grocery_app_2022/controller/order_controller.dart';

import '../../models/order.dart';
import '../../styles/app_layout.dart';
import '../../styles/styles.dart';

class OrdersStatus extends StatelessWidget {
  const OrdersStatus({super.key});

  @override
  Widget build(BuildContext context) {
    OrderController orderController = Get.put(OrderController());
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            Gap(AppLayout.getHeight(10)),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: ListView.separated(
                      itemCount: orderController.orders.length,
                      separatorBuilder: (context, index) => Gap(10),
                      itemBuilder: ((_, index) {
                        return OrdersList(
                          orderController: orderController,
                          order: orderController.orders[index],
                        );
                      }))),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersList extends StatelessWidget {
  const OrdersList({
    Key? key,
    required this.orderController,
    required this.order,
  }) : super(key: key);

  final OrderController orderController;
  final Order order;

  @override
  Widget build(BuildContext context) {
    print(order.cart);
    return Obx(
      () => GFAccordion(
        onToggleCollapsed: (value) {
          orderController.isOpen.value = value;
        },
        expandedTitleBackgroundColor: Colors.white,
        titleBorderRadius: orderController.isOpen.value == true
            ? const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
        contentBorderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        margin: EdgeInsets.all(0),
        titleChild: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${order.cart!.length} Products'),
                    Text('Total: ${order.total} USD'),
                  ],
                ),
                Column(children: [
                  Text(order.date.toString()),
                  Text(order.status.toString()),
                ]),
              ],
            ),
          ],
        ),
        contentChild: order.cart!.isNotEmpty
            ? Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: order.cart!.length,
                    separatorBuilder: (context, index) =>
                        Divider(color: Styles.primaryColor),
                    itemBuilder: ((_, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.network(
                                'http://clipart-library.com/images/8TEbenojc.jpg',
                                height: AppLayout.getHeight(50),
                                width: AppLayout.getWidth(50),
                              ),
                            ),
                          ]),
                          Gap(10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(order.cart![index].products[index]
                                //     .toString()),
                                Text('Quantity x Price'),
                              ]),
                          Spacer(),
                          Column(children: [
                            Text('Total Price : 200 USD'),
                          ]),
                        ],
                      );
                    }),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}

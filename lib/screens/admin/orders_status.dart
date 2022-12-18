import 'package:flutter/gestures.dart';
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
  const OrdersStatus({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    OrderController orderController = Get.find();
    orderController.getOrdersByStatus(status);
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
        margin: const EdgeInsets.all(0),
        titleChild: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${order.cart!.length} Products',
                        style: Styles.headLineStyle4),
                    Text('Total: ${order.total} USD',
                        style: Styles.headLineStyle4),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(order.date.toString(), style: Styles.headLineStyle4),
                  Text(order.status.toString(),
                      style: Styles.headLineStyle4
                          .copyWith(color: Styles.orangeColor)),
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.network(
                                order.cart![index].imageUrl.toString(),
                                height: AppLayout.getHeight(50),
                                width: AppLayout.getWidth(50),
                              ),
                            ),
                          ]),
                          Gap(10),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(order.cart![index].title.toString(),
                                    style: Styles.headLineStyle4),
                                Text(
                                    '${order.cart![index].quantity} st * ${order.cart![index].price}\$',
                                    style: Styles.headLineStyle4),
                              ]),
                          Spacer(),
                          Column(children: [
                            Text(
                                '${order.cart![index].quantity! * order.cart![index].price}\$'
                                    .toString(),
                                style: Styles.headLineStyle4),
                          ]),
                        ],
                      );
                    }),
                  ),
                  Divider(color: Styles.primaryColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Customer name:', style: Styles.headLineStyle4),
                      Text(
                        order.user!['name'],
                        style: Styles.headLineStyle4,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mobile:', style: Styles.headLineStyle4),
                      Text(order.user!['phone'], style: Styles.headLineStyle4),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping address:', style: Styles.headLineStyle4),
                      Text(order.user!['address'],
                          style: Styles.headLineStyle4),
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      order.status != 'delivered'
                          ? RichText(
                              text: TextSpan(
                              style: Styles.headLineStyle4,
                              text: order.status == 'preparing'
                                  ? 'Confirm the order: '
                                  : 'Delivered order: ',
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      orderController.updateOrder(order);
                                    },
                                  text: 'Confirm',
                                  style: Styles.headLineStyle4.copyWith(
                                      decoration: TextDecoration.underline,
                                      color: Styles.orangeColor),
                                ),
                              ],
                            ))
                          : Text('Delivered order',
                              style: Styles.headLineStyle4),
                    ],
                  ),
                  Gap(10),
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                        style: Styles.headLineStyle4,
                        text: 'Cancel & Delete the order: ',
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                orderController.deleteOrder(order.id!);
                              },
                            text: 'Cancel ',
                            style: Styles.headLineStyle4.copyWith(
                                decoration: TextDecoration.underline,
                                color: Styles.orangeColor),
                          ),
                        ],
                      )),
                    ],
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}

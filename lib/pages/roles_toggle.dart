import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/controller/user_controller.dart';
import 'user_page.dart';
import 'admin_page.dart';

class RolesToggle extends StatelessWidget {
  RolesToggle({super.key});

  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    userController.getUser();
    return Obx(() {
      if (userController.userFirebase == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (userController.myUser.isAdmin == true) {
          return const AdminPage();
        } else {
          return UserPage();
        }
      }
    });
  }
}

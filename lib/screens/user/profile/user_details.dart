import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:grocery_app_2022/controller/image_controller.dart';
import 'package:grocery_app_2022/models/user.dart';
import 'package:grocery_app_2022/screens/user/profile/profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

import '../../../controller/user_controller.dart';
import '../../../styles/app_layout.dart';
import '../../../styles/styles.dart';
import '../../../widgets/build_image.dart';
import 'components/profile_appbar.dart';

class UserDetails extends StatelessWidget {
  UserDetails({super.key});
  UserController userController = Get.put(UserController());
  ImageController imageController = Get.put(ImageController());
  final formKey = GlobalKey<FormState>();

  Future updateUser() async {
    MyUser user = MyUser(
      uid: userController.userFirebase!.uid,
      imageUrl: imageController.imagePath == ''
          ? userController.userFirebase!.photoURL
          : imageController.imagePath,
      isAdmin: userController.myUser.isAdmin,
      name: userController.editUser['Name'] == null
          ? userController.myUser.name.toString()
          : userController.editUser['Name'],
      email: userController.editUser['Email'] == null
          ? userController.myUser.email.toString()
          : userController.editUser['Email'],
      phone: userController.editUser['Phone'] == null
          ? userController.myUser.phone.toString()
          : userController.editUser['Phone'],
      address: userController.editUser['Address'] == null
          ? userController.myUser.address.toString()
          : userController.editUser['Address'],
    );
    userController.updateUser(user);
    userController.getUser();

//     if (formKey.currentState!.validate()) {
//       formKey.currentState!.save();
// //await userController.updateUser();
//     }
  }

  @override
  Widget build(BuildContext context) {
    userController.getUser();
    return Scaffold(
      body: ListView(children: [
        ProfileAppBar(title: 'Edit Profile'),
        Obx(
          () => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                BuildImage(
                    imageUrl: userController.myUser.imageUrl,
                    imagePath: imageController.image,
                    callback: () => imageController.pickImage()),
                const Gap(10),
                // Text(userController.userFirebase!.uid),
                // Text(userController.myUser.uid.toString()),
                Text(userController.myUser.name.toString(),
                    style: Styles.textStyle),
                Text(userController.myUser.email.toString(),
                    style: Styles.headLineStyle4),
                Text(userController.myUser.address.toString(),
                    style: Styles.headLineStyle4),
                Text(userController.myUser.phone.toString(),
                    style: Styles.headLineStyle4),
                const Gap(20),
                BuildTextFormField(
                    'Name',
                    userController.myUser.name.toString(),
                    userController,
                    UniconsLine.user),
                const Gap(10),
                BuildTextFormField(
                    'Email',
                    userController.myUser.email.toString(),
                    userController,
                    UniconsLine.envelope),
                const Gap(10),
                BuildTextFormField(
                    'Address',
                    userController.myUser.address.toString(),
                    userController,
                    UniconsLine.location_arrow),
                const Gap(10),
                BuildTextFormField(
                    'Phone',
                    userController.myUser.phone.toString(),
                    userController,
                    UniconsLine.phone),
                const Gap(40),
                SizedBox(
                  height: AppLayout.getHeight(50),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await updateUser();
                    },
                    child: Text('Update User'),
                  ),
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  TextFormField BuildTextFormField(
    String title,
    String hintText,
    UserController userController,
    IconData icon,
  ) {
    return TextFormField(
      validator: (value) => value!.isEmpty ? 'Enter a valid value' : null,
      onChanged: (value) => {
        userController.editUser
            .update(title, (_) => value, ifAbsent: () => value)
      },
      decoration: Styles.inputDecoration.copyWith(
        prefixIcon: Icon(icon, color: Styles.orangeColor),
        hintText: hintText,
        labelText: title,
      ),
    );
  }
}

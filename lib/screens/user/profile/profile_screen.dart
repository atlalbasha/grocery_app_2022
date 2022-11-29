import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/controller/user_controller.dart';

import 'package:grocery_app_2022/screens/user/profile/components/profile_item.dart';
import 'package:grocery_app_2022/screens/user/profile/help_support.dart';
import 'package:grocery_app_2022/screens/user/profile/settings.dart.dart';
import 'package:grocery_app_2022/screens/user/profile/user_details.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

import '../../../styles/app_layout.dart';
import '../../../styles/styles.dart';
import '../../../widgets/build_image.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    userController.getUser();
    return Scaffold(
      body: ListView(
        children: [
          Gap(AppLayout.getHeight(50)),
          Obx(
            () => Container(
                height: AppLayout.getHeight(150),
                width: AppLayout.getWidth(150),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.orangeColor,
                ),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: userController.myUser.imageUrl == null
                        ? AssetImage('assets/images/user.png')
                        : NetworkImage(userController.myUser.imageUrl!)
                            as ImageProvider,
                    radius: 150.0,
                  ),
                )),
          ),
          Gap(AppLayout.getHeight(20)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userController.myUser.name.toString(),
                style: Styles.textStyle,
              ),
              Text(
                userController.myUser.email.toString(),
                style: Styles.headLineStyle4,
              ),
            ],
          ),
          Gap(AppLayout.getHeight(20)),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              height: AppLayout.getHeight(70),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Styles.secondaryColor.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(UniconsLine.clipboard_notes,
                          color: Styles.primaryColor),
                      Text('My Orders', style: Styles.textStyle),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(UniconsLine.wallet, color: Styles.primaryColor),
                      Text('Payment', style: Styles.textStyle),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(UniconsLine.location_point,
                          color: Styles.primaryColor),
                      Text('Location', style: Styles.textStyle),
                    ],
                  ),
                ],
              )),
          Gap(AppLayout.getHeight(20)),
          ProfileItem(
            icon: UniconsLine.user,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => UserDetails()))),
            title: 'User Details',
          ),
          ProfileItem(
            icon: UniconsLine.setting,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => Settings()))),
            title: 'Settings',
          ),
          ProfileItem(
            icon: UniconsLine.info_circle,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => HelpSupport()))),
            title: 'Help & Support',
          ),
          ProfileItem(
            icon: UniconsLine.sign_out_alt,
            onTap: () {
              userController.signOut();
            },
            title: 'Logout',
          ),
        ],
      ),
    );
  }
}

// class BuildImage extends StatelessWidget {
//   final XFile? imagePath;
//   final VoidCallback callback;
//   const BuildImage({
//     Key? key,
//     this.imagePath,
//     required this.callback,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
//         height: AppLayout.getHeight(150),
//         width: AppLayout.getWidth(150),
//         child: InkWell(
//           onTap: () async {
//             callback();
//           },
//           child: imagePath != null
//               ? ClipOval(
//                   child: Image.file(
//                     File(imagePath!.path),
//                     fit: BoxFit.fill,
//                     height: double.infinity,
//                     width: double.infinity,
//                   ),
//                 )
//               : ClipOval(
//                   child: Container(
//                     height: double.infinity,
//                     width: double.infinity,
//                     color: Styles.orangeColor,
//                     child: Center(
//                       child: Icon(
//                         Icons.add_a_photo_outlined,
//                         color: Styles.whiteColor,
//                         size: 80,
//                       ),
//                     ),
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }

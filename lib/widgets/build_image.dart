import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';
import '../styles/app_layout.dart';
import '../styles/styles.dart';

class BuildImage extends StatelessWidget {
  final XFile? imagePath;
  final VoidCallback callback;
  final String? imageUrl;
  const BuildImage({
    Key? key,
    this.imagePath,
    required this.callback,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => callback(),
        child: Center(
          child: Container(
              height: AppLayout.getHeight(150),
              width: AppLayout.getWidth(150),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Styles.orangeColor,
              ),
              child: Center(
                child: imagePath == null
                    ? CircleAvatar(
                        backgroundImage: imageUrl == null
                            ? AssetImage('assets/images/user.png')
                            : NetworkImage(imageUrl!) as ImageProvider,
                        radius: 150.0,
                      )
                    : CircleAvatar(
                        backgroundColor: Styles.orangeColor,
                        backgroundImage: FileImage(File(imagePath!.path)),
                        radius: 150.0,
                      ),
              )),
        ),
      ),
    );
  }
}



// Container(
//         margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
//         height: AppLayout.getHeight(150),
//         width: AppLayout.getWidth(150),
//         child: InkWell(
//           onTap: () async {
//             callback();
//           },
//           child: imagePath != null
//               ?

//               ClipOval(
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
//                         UniconsLine.image_plus,
//                         color: Styles.whiteColor,
//                         size: 80,
//                       ),
//                     ),
//                   ),
//                 ),
//         ),
//       ),

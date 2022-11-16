import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../../styles/styles.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              child: Icon(
                UniconsLine.angle_left_b,
                color: Styles.primaryColor,
              ),
            ),
          ),
          Text(
            title,
            style: Styles.headLineStyle2,
          ),
          InkWell(
            onTap: () {},
            child: Icon(
              UniconsLine.angle_left_b,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

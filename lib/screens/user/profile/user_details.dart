import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:unicons/unicons.dart';

import '../../../styles/styles.dart';
import 'components/profile_appbar.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          ProfileAppBar(title: 'User Details'),
        ],
      ),
    );
  }
}

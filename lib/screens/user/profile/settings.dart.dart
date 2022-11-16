import 'package:flutter/material.dart';

import 'components/profile_appbar.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          ProfileAppBar(title: 'Settings'),
        ],
      ),
    );
  }
}

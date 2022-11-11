import 'package:flutter/src/widgets/framework.dart';
import 'user_page.dart';
import 'admin_page.dart';

class RolesToggle extends StatefulWidget {
  const RolesToggle({super.key});

  @override
  State<RolesToggle> createState() => _RolesToggleState();
}

class _RolesToggleState extends State<RolesToggle> {
  bool isAdmin = false;
  @override
  Widget build(BuildContext context) =>
      isAdmin ? AdminPage(adminRole: toggle) : UserPage(userRole: toggle);

  void toggle() => setState(() {
        isAdmin = !isAdmin;
      });
}

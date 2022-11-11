import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app_2022/authentication/sign_in_page.dart';
import 'package:grocery_app_2022/authentication/sign_up_page.dart';

class AuthToggle extends StatefulWidget {
  const AuthToggle({super.key});

  @override
  State<AuthToggle> createState() => _AuthToggleState();
}

class _AuthToggleState extends State<AuthToggle> {
  bool isLogin = false;
  @override
  Widget build(BuildContext context) => isLogin
      ? SignInPage(onClickedSignIn: toggle)
      : SignUpPage(onClickedSignUp: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}

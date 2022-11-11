import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import '../styles/app_layout.dart';
import '../styles/styles.dart';

class SignInPage extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignInPage({super.key, required this.onClickedSignIn});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailOrMobile = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    emailOrMobile.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Gap(AppLayout.getHeight(40)),
              Image.asset(
                'assets/images/welcome.png',
                height: 200,
                width: 200,
              ),
              Gap(AppLayout.getHeight(40)),
              TextFormField(
                controller: emailOrMobile,
                validator: (value) =>
                    value!.isEmpty ? 'Enter a valid value' : null,
                decoration: Styles.inputDecoration.copyWith(
                  hintText: 'Email or Mobile',
                ),
              ),
              Gap(AppLayout.getHeight(20)),
              TextFormField(
                controller: password,
                validator: (value) =>
                    value!.isEmpty ? 'Enter a valid value' : null,
                decoration: Styles.inputDecoration.copyWith(
                  hintText: 'Password',
                ),
              ),
              Gap(AppLayout.getHeight(20)),
              SizedBox(
                height: AppLayout.getHeight(50),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Log in'),
                ),
              ),
              Gap(AppLayout.getHeight(20)),
              GestureDetector(
                child: Text(
                  'Forget Password?',
                  style: Styles.headLineStyle4,
                ),
                onTap: () {
                  //login();
                },
              ),
              Gap(AppLayout.getHeight(20)),
              RichText(
                  text: TextSpan(
                style: Styles.headLineStyle4,
                text: 'No account? ',
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignIn,
                    text: 'Sign Up',
                    style: Styles.headLineStyle4.copyWith(
                        decoration: TextDecoration.underline,
                        color: Styles.orangeColor),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

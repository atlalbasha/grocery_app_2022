import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:grocery_app_2022/styles/styles.dart';

import '../styles/app_layout.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Gap(AppLayout.getHeight(40)),
            Image.asset(
              'assets/images/verified.png',
              height: 200,
              width: 200,
            ),
            Gap(AppLayout.getHeight(40)),
            Text(
              'Verification,',
              style: Styles.headLineStyle3,
              textAlign: TextAlign.center,
            ),
            Text(
              'Enter your OTP code number,',
              style: Styles.headLineStyle4,
              textAlign: TextAlign.center,
            ),
            Gap(AppLayout.getHeight(40)),
            OtpTextField(
              numberOfFields: 6,
              filled: true,
              fillColor: Colors.white,
              focusedBorderColor: Styles.orangeColor,
              enabledBorderColor: Styles.secondaryColor,
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    });
              }, // end onSubmit
            ),
            Gap(AppLayout.getHeight(20)),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Styles.headLineStyle4,
                  text: 'Didn\'t receive the code? ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      text: 'Resend Code',
                      style: Styles.headLineStyle4.copyWith(
                          decoration: TextDecoration.underline,
                          color: Styles.orangeColor),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

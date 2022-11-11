import 'package:flutter/material.dart';
import 'package:grocery_app_2022/authentication/auth_toggle.dart';
import 'package:grocery_app_2022/pages/roles_toggle.dart';
import 'package:grocery_app_2022/styles/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Styles.bgColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Styles.primaryColor, primary: Styles.primaryColor),
        textTheme: TextTheme(
            headline1: Styles.headLineStyle1,
            headline2: Styles.headLineStyle2,
            headline3: Styles.headLineStyle3,
            headline4: Styles.headLineStyle4,
            button: Styles.headLineStyle3),
      ),
      home: false ? AuthToggle() : RolesToggle(), // RolesToggle(),
    );
  }
}

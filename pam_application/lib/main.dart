import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pam_application/views/loginpage.dart';
import 'package:pam_application/views/registration.dart';
// import 'package:pam_application/views/users/homepage_user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage()
    );
  }
}

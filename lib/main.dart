import 'package:blood_donation_app/Splash.dart';
import 'package:blood_donation_app/home.dart';
import 'package:blood_donation_app/landing%20page.dart';
import 'package:blood_donation_app/login.dart';
import 'package:blood_donation_app/tips.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

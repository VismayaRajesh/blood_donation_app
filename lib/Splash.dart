import 'package:blood_donation_app/landing%20page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Positioned(
                top: 272,
                left: 127,
                child: Container(
                  height: 110,
                  width: 110,
                  child: Image(image: AssetImage("assets/images/iconn.png")),
                ),
              ),
              Positioned(
                top: 375,
                left: 117,
                child: Text(
                  "EasyDonate",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF852424),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
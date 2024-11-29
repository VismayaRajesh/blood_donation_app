import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<LandingPage> _pages = [
    LandingPage(
      title: "Life Begins with a Drop of Blood",
      description: "Saving lives begins with a single act. Join our community of donors and make a difference today.",
      imagePath: "assets/images/Limg2.png",
    ),
    LandingPage(
      title: "Find Donors Nearby, Anytime",
      description: "Locate nearby blood donors instantly, whether for emergencies or regular donations. Help is just a click away.",
      imagePath: "assets/images/limg.jpg",
    ),
    LandingPage(
      title: "Safe, Simple, and Secure Donations",
      description: "Your safety is our priority. We collaborate with trusted individuals and communities to provide a secure and seamless donation experience.",
      imagePath: "assets/images/Limgg3.png",
      isLastPage: true,
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    _pageController.jumpToPage(_pages.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          final page = _pages[index];
          return LandingPage(
            title: page.title,
            description: page.description,
            imagePath: page.imagePath,
            isLastPage: page.isLastPage,
            onSkip: _skip,
            onNext: _nextPage,
          );
        },
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isLastPage;
  final VoidCallback? onSkip;
  final VoidCallback? onNext;

  LandingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    this.isLastPage = false,
    this.onSkip,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(  // Add this widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imagePath, height: 200),
                SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 120),  // Adjusted height
              ],
            ),
          ),
        ),

        // Bottom container with full-width
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 220,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFFBB2727),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                if (!isLastPage)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: onSkip,
                        child: Text("Skip", style: TextStyle(color: Colors.blue)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onNext,
                        child: Text("Next", style: TextStyle(color: Colors.blue)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                    ],
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text("Get Started", style: TextStyle(color: Colors.blue),),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:blood_donation_app/Screen/login.dart';
import 'package:blood_donation_app/Screen/profile.dart';
import 'package:blood_donation_app/Screen/tips.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../database/dbhelper.dart';
import 'details.dart';
import 'findD.dart';
import '../database/model.dart';
import 'notification.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _current = 0;
  final List<String> imgList = [
    'assets/images/imgg2.png',
    'assets/images/imgg3.png',
    'assets/images/imgg1.png',
  ];

  int _currentIndex = 0;

  List<Widget>pages = [
    Home(),
    FindDonorPage(),
    Profile(),
    Notifications()
  ];

  late Future<List<User>?> donatorListFuture;


  @override
  void initState() {
    super.initState();
    final DatabaseHelper databaseHelper = DatabaseHelper();
    donatorListFuture = databaseHelper.getAll(); // Initialize the future only once
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFBB2727),
          toolbarHeight: 65,
          iconTheme: IconThemeData(color: Colors.white),
          title: Row(
            children: [
              PopupMenuButton<String>(
                icon: Icon(Icons.menu, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onSelected: (value) {
                  if (value == 'logout') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'logout',
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Slightly reduced padding
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Color(0xFFBB2727), size: 18), // Reduced icon size
                        SizedBox(width: 12),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Color(0xFFBB2727),
                            fontSize: 14, // Reduced font size
                            fontWeight: FontWeight.w500, // Slightly reduced font weight
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello User!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.white, size: 14),
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: IconButton(
                icon: Icon(Icons.notifications_none, color: Colors.white, size: 26),
                onPressed: () {
                  // Action for notifications icon
                },
              ),
            ),
          ],
        ),
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 162,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.95,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: imgList.map((item) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.95,
                    ),
                  ),
                )).toList(),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return Container(
                  width: _currentIndex == entry.key ? 12.0 : 8.0,
                  height: _currentIndex == entry.key ? 12.0 : 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? Color(0xFFBB2727)
                        : Colors.grey.shade300,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 18),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildQuickAction(
                    icon: Icons.search,
                    label: 'Find Donor',
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FindDonorPage()),
                      );
                    },
                  ),
                  buildQuickAction(
                    icon: Icons.add,
                    label: 'Donate',
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserDetailsPage()),
                      );
                      // Refresh the donor list after returning
                      setState(() {
                        donatorListFuture = DatabaseHelper().getAll(); // Re-fetch the donor list
                      });
                    },
                  ),
                  buildQuickAction(
                    icon: Icons.lightbulb_outline,
                    label: 'Donate Tips',
                    onTap: () async {
                        await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Tips()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Donators',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 6),
            Flexible(
              child: _mylist(),
            ),
          ],
        ),
        //children: [pages[_current]],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _current, // Manage the selected index
            onTap: (index) {
              setState(() {
                _current = index;
              });
            },
              items:
              [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
          selectedItemColor: Color(0xFFBB2727),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget buildQuickAction({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Color(0xFFBB2727), size: 30),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(color: Color(0xFFBB2727), fontSize: 14, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _mylist() {
    return FutureBuilder<List<User>?>(
      future: donatorListFuture,
      builder: (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No donator data found"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = snapshot.data![index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(8),
                      shadowColor: Colors.grey.shade300,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFFBB2727),
                          child: Text(
                            user.name.isNotEmpty ? user.name[0] : '?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          user.name,
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        subtitle: Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 14, color: Colors.grey.shade600,),
                            Text(
                              user.location,
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.bloodType,
                                  style: TextStyle(
                                    color: Color(0xFFBB2727),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 9), // Add some space between the elements
                            IconButton(
                              onPressed: (){
                                CallPhone(user.phone);
                              },
                                icon: Icon(Icons.phone, color: Color(0xFFBB2727))), // Phone icon
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          default:
            return Center(child: Text("Unknown state"));
        }
      },
    );
  }
  void  CallPhone(String number){
    Uri _call = Uri.parse("tel: $number");
    launchUrl(_call);
  }
}
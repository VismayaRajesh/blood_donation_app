import 'package:flutter/material.dart';

import '../model/login/Userlogin.dart';
import '../service/sharedPreferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserData();
  }
  String userName = "User"; // Default value
  String userLocation = "Location";
  String useremail = "Email";// Default value

  // Fetch user details from SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferenceHelper preferenceHelper = SharedPreferenceHelper();
    Userlogin? userLogin = await preferenceHelper.getLoginData();
    if (userLogin != null) {
      setState(() {
        userName = userLogin.name ?? "User"; // Fallback to default if null
        userLocation = userLogin.place ?? "Location";
        useremail = userLogin.email ?? "Email";
        // Fallback to default if null
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // AppBar Background
          Container(
            height: 130,
            decoration: const BoxDecoration(
              color: Color(0xFFBB2727),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
          ),

          // Profile Content
          Padding(
            padding: const EdgeInsets.only(top: 65),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: 50, // Adjust the radius of the profile picture
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 45, // Adjust the inner profile size
                        backgroundColor: Color(0xFFBB2727),
                        child: Text(
                            userName.isNotEmpty ? userName[0].toUpperCase() : "U", // Placeholder initials
                          style: const TextStyle(
                            fontSize: 30, // Adjust font size of initials to match profile size
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Text(
                  userName, // Placeholder name
                  style: TextStyle(
                    fontSize: 26, // Increased font size
                    fontWeight: FontWeight.w800, // Thicker font weight
                    color: Colors.black87,
                  ),
                ),

                // Blood Group (Increased font size and bold)
                Text(
                  "O+", // Placeholder blood group
                  style: TextStyle(
                    fontSize: 22, // Increased font size
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Profile Information Card
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20), // Increased padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoColumn("Number of Donations", "12", Icons.volunteer_activism, Colors.purple),
                        Divider(), // Divider added
                        _infoColumn("Phone Number", "+1 234 567 890", Icons.phone, Colors.purple),
                        Divider(), // Divider added
                        _infoColumn("Email", useremail, Icons.email, Colors.purple),
                        Divider(), // Divider added
                        _infoColumn("Location", userLocation, Icons.location_on, Colors.purple),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: TextButton(onPressed: (){}, child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    Icon(Icons.edit, color: Colors.blue, size: 22,),
                    Text("Edit profile", style: TextStyle(color: Colors.blue, fontSize: 16),)
                  ],)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Information Column Widget for subheading and value with icon
  Widget _infoColumn(String title, String value, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 22), // Icon added with custom color
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

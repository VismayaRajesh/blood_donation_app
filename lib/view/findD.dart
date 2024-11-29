import 'package:flutter/material.dart';
import 'home.dart';
import '../database/model.dart'; // Ensure this imports the User model
import '../database/dbhelper.dart'; // Ensure this imports your database helper class

class FindDonorPage extends StatefulWidget {
  @override
  _FindDonorPageState createState() => _FindDonorPageState();
}

class _FindDonorPageState extends State<FindDonorPage> {
  late Future<List<User>?> donatorListFuture;
  List<User> _donors = [];
  List<User> _filteredDonors = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchDonors();
    _searchController.addListener(_filterDonors);
  }

  Future<void> _fetchDonors() async {
    final DatabaseHelper databaseHelper = DatabaseHelper();
    final donors = await databaseHelper.getAll();
    setState(() {
      _donors = donors ?? [];
      _filteredDonors = _donors;
    });
  }

  void _filterDonors() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDonors = _donors.where((donor) {
        return donor.name.toLowerCase().contains(query) ||
            donor.location.toLowerCase().contains(query) ||
            donor.bloodType.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBB2727),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Find Donor',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchContainer(),
            SizedBox(height: 16),
            Expanded(child: _buildDonorList()),
          ],
        ),
      ),
    );
  }

  Widget SearchContainer() {
    return Container(
      height: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search for a donor...',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildDonorList() {
    return _filteredDonors.isEmpty
        ? Center(child: Text("No donor data found"))
        : ListView.builder(
      itemCount: _filteredDonors.length,
      itemBuilder: (BuildContext context, int index) {
        final user = _filteredDonors[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
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
                  Icon(Icons.location_on_outlined, size: 14),
                  Text(
                    user.location,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
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
                  SizedBox(width: 8),
                  Icon(Icons.phone, color: Color(0xFFBB2727)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

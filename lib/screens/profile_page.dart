import 'package:flutter/material.dart';
import 'package:waypoints_n_chill/models/bottomnavbar.dart';
import 'package:waypoints_n_chill/screens/settings_page.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String username;

  ProfilePage({required this.email, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8C7FD),
      appBar: AppBar(
        backgroundColor: Color(0xFF664AB2),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'MarketDeco',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Email: $email'),
            Text('Username: $username'),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          _handleBottomNavTap(index, context);
        },
      ),
    );
  }

  void _handleBottomNavTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        // Navigate to Dashboard/Home Page
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        // Navigate to Search Page
        Navigator.pushNamed(context, '/search');
        break;
    }
  }
}

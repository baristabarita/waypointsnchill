import 'package:flutter/material.dart';
import 'package:waypoints_n_chill/screens/login_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8C7FD),
      appBar: AppBar(
        backgroundColor: Color(0xFF664AB2),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white, 
            fontFamily: 'MarketDeco',
          ),
        ),
        // Navigate back to the Home Page
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Thank you for using Waypoints n Chill!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF67FAFB),
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: 'Fortune',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Below this paragraph is the logout button to take you back to the login page. Stay safe and Take Care!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Cupcake',
                ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Login Page
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
              child: Text('LOGOUT'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFEEC472),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

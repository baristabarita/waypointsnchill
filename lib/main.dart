import 'package:flutter/material.dart';
import 'package:waypoints_n_chill/screens/login_page.dart';
import 'package:waypoints_n_chill/screens/home_page.dart';
import 'package:waypoints_n_chill/screens/details_page.dart';
import 'package:waypoints_n_chill/screens/settings_page.dart';
import 'package:waypoints_n_chill/screens/profile_page.dart';
import 'package:waypoints_n_chill/screens/search_page.dart'; 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/details': (context) => DetailsPage(country: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/settings': (context) => SettingsPage(),
        '/profile': (context) => ProfilePage(email: 'sample@email.com', username: 'Sample User'), // Define ProfilePage route
        '/search': (context) => SearchPage(),
      },
    );
  }
}

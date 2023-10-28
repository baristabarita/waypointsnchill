import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:waypoints_n_chill/models/bottomnavbar.dart';
import 'dart:convert';
import 'package:waypoints_n_chill/screens/details_page.dart';
import 'package:waypoints_n_chill/screens/settings_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>>? _countries;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchCountriesData();
  }

  Future<void> _fetchCountriesData() async {
    try {
      final response =
          await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> countries =
            (json.decode(response.body) as List)
                .cast<Map<String, dynamic>>()
                .toList();

        setState(() {
          _countries = countries;
        });
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _navigateToDetailsPage(Map<String, dynamic>? country) {
    if (country != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailsPage(country: country)),
      );
    }
  }

  void _handleBottomNavTap(int index, BuildContext context) {
    switch (index) {
      case 1:
        // Navigate to Search Page
        Navigator.pushNamed(context, '/search');
        break;
      case 2:
        // Navigate to Profile Page
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8C7FD),
      appBar: AppBar(
        backgroundColor: Color(0xFF664AB2), 
        title: Text(
          'Dashboard',
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
      body: 
          _countries == null
          ? Center(child: CircularProgressIndicator()) 
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome to Waypoints and Chill!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Here below are the list of countries. Tap on one of them and you will see some of the important details about the country',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
              itemCount: _countries!.length,
              itemBuilder: (context, index) {
                final country = _countries![index];
                final commonName = country['name']?['common'] ?? 'N/A';
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0), // Add space between boxes
                  child: GestureDetector(
                    onTap: () {
                      _navigateToDetailsPage(country);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            BorderRadius.circular(8.0), 
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        commonName,
                        style: TextStyle(
                            fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
                ),
              ],
            ), 
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _handleBottomNavTap(index, context);
        },
      ),
    );
  }
}

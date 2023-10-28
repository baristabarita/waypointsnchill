import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:waypoints_n_chill/screens/details_page.dart';
import 'package:waypoints_n_chill/screens/settings_page.dart';
import 'package:waypoints_n_chill/models/bottomnavbar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> _searchResults = [];

  void _handleSearch(String query) async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/name/$query'));

    if (response.statusCode == 200) {
      setState(() {
        _searchResults =
            (json.decode(response.body) as List).cast<Map<String, dynamic>>();
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  void _navigateToDetailsPage(Map<String, dynamic> country) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage(country: country)),
    );
  }

  void _handleBottomNavTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        // Navigate to Dashboard/Home Page
        Navigator.pushNamed(context, '/home');
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
          'Search',
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _handleSearch,
              decoration: InputDecoration(
                labelText: 'Enter country name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFC9CDE9),
                labelStyle: TextStyle( color: Color(0xFF7B79FE), fontSize: 20, fontWeight: FontWeight.bold), // Set label text color
                hintStyle: TextStyle(color: Color(0xFF7B79FE), fontSize: 20, fontWeight: FontWeight.bold), // Set hint text color
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final country = _searchResults[index];
                final countryName = country['name']?['common'] ?? 'N/A';
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0),
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
                        countryName,
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
        currentIndex: 1,
        onTap: (index) {
          _handleBottomNavTap(index, context);
        },
      ),
    );
  }
}

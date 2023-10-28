import 'package:flutter/material.dart';
import 'package:waypoints_n_chill/screens/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8C7FD),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 80,
                color: Colors.deepPurple[400],
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  'lib/icons/way.png',
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              'Waypoints n Chill',
              style: TextStyle(
                fontFamily: 'Cupcake',
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Color(0xFF2C1747),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'A small Lofi-Colored Mobile App with information of countries around the world', 
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.0),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  filled: true, 
                  fillColor: Colors.white, 
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  filled: true, 
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  // Navigate to Home Page if login is successful
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid email or password')),
                  );
                }
              },
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2C1747),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

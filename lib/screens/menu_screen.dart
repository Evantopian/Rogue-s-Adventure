import 'dart:async';
import 'package:flutter/material.dart';
import './login_screen.dart'; // Import the login page
import './signup_screen.dart'; // Import the signup page

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _showText = true;

  @override
  void initState() {
    super.initState();
    // Timer to toggle the visibility of the text every 500 milliseconds / blinking text
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _showText = !_showText;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.login),
                    title: Text('Login'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add),
                    title: Text('Sign Up'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/menu_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: AnimatedOpacity(
              opacity: _showText ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Text(
                'Touch to Start',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

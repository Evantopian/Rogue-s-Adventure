import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './homepage.dart'; // Import the home page

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _showEmailPasswordFields = false;

  Future<void> _signUpWithEmailAndPassword(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final User? user = userCredential.user;
      // Navigate to the next screen after successful sign-up
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'Logged in')));
    } catch (e) {
      // Handle errors such as invalid email/password or user already exists
      print('Failed to sign up with email and password: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign up Failed'),
          content:
              Text('An error occurred while signing up. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.3;
    double textFieldWidth = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/background/menu_background.png',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!_showEmailPasswordFields)
                        Text(
                          'Logo Text', // Add logo text here
                          style: TextStyle(color: Colors.white, fontSize: 24.0),
                        ),
                      SizedBox(height: 16.0),
                      if (!_showEmailPasswordFields)
                        Text(
                          'Choose a sign up method',
                          style: TextStyle(color: Colors.white),
                        ),
                      SizedBox(height: 16.0),
                      _showEmailPasswordFields
                          ? _emailPasswordFields(textFieldWidth)
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: buttonWidth,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          // Handle Google sign-up
                                        },
                                        icon: Image.asset(
                                          'assets/logos/google_logo.png',
                                          height: 24.0,
                                          width: 24.0,
                                        ),
                                        label: Text('Sign Up with Google'),
                                      ),
                                    ),
                                    SizedBox(width: 16.0),
                                    SizedBox(
                                      width: buttonWidth,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          // Handle Facebook sign-up
                                        },
                                        icon: Image.asset(
                                          'assets/logos/facebook_logo.png',
                                          height: 24.0,
                                          width: 24.0,
                                        ),
                                        label: Text('Sign Up with Facebook'),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.0),
                                SizedBox(
                                  width: buttonWidth,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _showEmailPasswordFields =
                                            !_showEmailPasswordFields;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/logos/person_logo_2.png',
                                          height: 24.0,
                                          width: 24.0,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text('Sign Up with Email'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 24.0),
                      if (_showEmailPasswordFields)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showEmailPasswordFields = false;
                            });
                          },
                          child: Text('Back'),
                        ),
                      SizedBox(height: 24.0),
                      if (!_showEmailPasswordFields)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                                context); // Navigate back to the menu screen
                          },
                          child: Text('Back to Menu'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailPasswordFields(double textFieldWidth) {
    return Column(
      children: [
        Container(
          width: textFieldWidth,
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          width: textFieldWidth,
          child: TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
        ),
        SizedBox(height: 16.0),
        SizedBox(
          child: ElevatedButton(
            onPressed: () => _signUpWithEmailAndPassword(context),
            child: Text('Sign Up'),
          ),
        ),
      ],
    );
  }
}

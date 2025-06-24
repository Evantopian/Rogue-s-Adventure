import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './homepage.dart'; // Import the home page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _showEmailPasswordFields = false;

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final User? user = userCredential.user;
      // Navigate to the home page after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'Logged in')),
      );
    } catch (e) {
      // Handle errors such as invalid email/password or user not found
      print('Failed to sign in with email and password: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign in Failed'),
          content: Text('Invalid email or password. Please try again.'),
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
                      _showEmailPasswordFields
                          ? SizedBox
                              .shrink() // Hide text when email/password fields are shown
                          : Text(
                              'Choose a login method',
                              style: TextStyle(color: Colors.white),
                            ),
                      SizedBox(height: 16.0),
                      _showEmailPasswordFields
                          ? Column(
                              children: [
                                SizedBox(height: 16.0),
                                Container(
                                  width: textFieldWidth,
                                  child: TextField(
                                    controller: _emailController,
                                    decoration:
                                        InputDecoration(labelText: 'Email'),
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Container(
                                  width: textFieldWidth,
                                  child: TextField(
                                    controller: _passwordController,
                                    decoration:
                                        InputDecoration(labelText: 'Password'),
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(height: 24.0),
                                ElevatedButton(
                                  onPressed: () =>
                                      _signInWithEmailAndPassword(context),
                                  child: Text('Sign In'),
                                ),
                                SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showEmailPasswordFields = false;
                                    });
                                  },
                                  child: Text('Back'),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: buttonWidth,
                                      child: _buildImageButton(
                                        'Sign In With Google',
                                        'assets/logos/google_logo.png',
                                        () {
                                          // Handle Google sign-in
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 16.0),
                                    SizedBox(
                                      width: buttonWidth,
                                      child: _buildImageButton(
                                        'Sign In With Facebook',
                                        'assets/logos/facebook_logo.png',
                                        () {
                                          // Handle Facebook sign-in
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: buttonWidth,
                                      child: _buildImageButton(
                                        'Play With Guest Account',
                                        'assets/logos/person_logo_2.png',
                                        () {
                                          // Handle Guest sign-in
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 16.0),
                                    SizedBox(
                                      width: buttonWidth,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _showEmailPasswordFields = true;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/logos/person_logo_2.png',
                                              height: 24.0,
                                              width: 24.0,
                                            ),
                                            SizedBox(width: 8.0),
                                            Text('Sign In With Email'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (!_showEmailPasswordFields)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
        ],
      ),
    );
  }

  Widget _buildImageButton(
      String text, String imagePath, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: 24.0,
            width: 24.0,
          ),
          SizedBox(width: 8.0),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

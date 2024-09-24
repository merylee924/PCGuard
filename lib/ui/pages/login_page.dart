import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crypto/crypto.dart'; // Import for password hashing
import 'dart:convert';
import 'package:test_project/ui/pages/theme.dart';
import '../../components/button.dart';
import '../../components/textfield.dart'; // Needed for UTF-8 encoding

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isDarkMode = false;

  Future<void> signUserIn() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog('Please enter both email and password.');
      return;
    }

    try {
      // Hash the password using SHA-256
      final hashedPassword = sha256.convert(utf8.encode(password)).toString();

      // Fetch user data from Supabase
      final userResponse = await Supabase.instance.client
          .from('users')
          .select('id, email, hashed_password')
          .eq('email', username)
          .single()
          .execute();

      final user = userResponse.data;

      if (user == null) {
        _showErrorDialog('User not found.');
        return;
      }

      if (user['hashed_password'] != hashedPassword) {
        _showErrorDialog('Incorrect password.');
        return;
      }

      // Sign in with Supabase Auth
      final authResponse = await Supabase.instance.client.auth.signInWithPassword(
        email: username,
        password: password, // Use plain password for Supabase Auth
      );

      if (authResponse.error != null) {
        _showErrorDialog('Authentication failed: ${authResponse.error!.message}');
      } else {
        Navigator.of(context).pushReplacementNamed('/homepage');
      }
    } catch (error) {
      _showErrorDialog('Failed to sign in: $error');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = isDarkMode ? CustomTheme.darkTheme() : CustomTheme.lightTheme();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
              color: theme.primaryColor,
            ),
            onPressed: toggleDarkMode,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInDown(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    'Welcome back, you\'ve been missed!',
                    style: TextStyle(
                      color: theme.colorScheme.secondary, // Updated from accentColor
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                FadeInDown(
                  delay: const Duration(milliseconds: 400),
                  child: MyTextField(
                    controller: usernameController,
                    hintText: 'Email',
                    obscureText: false,
                    hintColor: theme.hintColor,
                    textColor: theme.textTheme.bodyLarge?.color,
                    fillColor: theme.inputDecorationTheme.fillColor,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInDown(
                  delay: const Duration(milliseconds: 600),
                  child: MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    hintColor: theme.hintColor,
                    textColor: theme.textTheme.bodyLarge?.color,
                    fillColor: theme.inputDecorationTheme.fillColor,
                  ),
                ),
                const SizedBox(height: 10),
                FadeInDown(
                  delay: const Duration(milliseconds: 800),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Forgot password action
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: theme.colorScheme.secondary, // Updated from accentColor
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                FadeInDown(
                  delay: const Duration(milliseconds: 1000),
                  child: MyButton(
                    onTap: signUserIn,
                    text: 'Sign In',
                    buttonColor: theme.colorScheme.primary ?? Colors.blue, // Updated buttonColor
                    textColor: theme.colorScheme.onPrimary ?? Colors.white, // Updated textColor
                  ),
                ),
                const SizedBox(height: 50),
                FadeInDown(
                  delay: const Duration(milliseconds: 1200),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/signup');
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(color: theme.colorScheme.secondary), // Updated from accentColor
                        children: [
                          TextSpan(
                            text: ' Sign up',
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on AuthResponse {
  get error => null;
}

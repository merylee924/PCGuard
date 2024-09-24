import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crypto/crypto.dart'; // Import for password hashing
import 'dart:convert';

class SignUpPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController(); // Nouveau champ pour le prénom
  final lastNameController = TextEditingController(); // Nouveau champ pour le nom
  final phoneNumberController = TextEditingController(); // Nouveau champ pour le numéro de téléphone

  Future<void> signUserUp(BuildContext context) async {
    final email = usernameController.text.trim();
    final password = passwordController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();

    if (email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty) {
      _showCustomToast(context, 'Please fill all fields.', Colors.orange, Icons.warning);
      return;
    }

    try {
      // Hash the password using SHA-256
      final hashedPassword = sha256.convert(utf8.encode(password)).toString();

      // Store the user data in Supabase
      final response = await Supabase.instance.client
          .from('users')
          .insert({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phoneNumber,
        'hashed_password': hashedPassword,
      })
          .execute();

      if (response.error == null) {
        // Show success toast
        _showCustomToast(context, 'Account successfully created!', Colors.green, Icons.check_circle);

        // Redirect to Welcome Page after showing the toast
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacementNamed('/welcome_page');
        });
      } else {
        throw response.error!.message;
      }
    } catch (e) {
      _showCustomToast(context, 'Failed to create account: $e', Colors.red, Icons.error);
    }
  }

  void _showCustomToast(BuildContext context, String message, Color color, IconData icon) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50, // Position en haut
        right: 20, // Position à droite
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 12),
                IconButton(
                  onPressed: () {
                    entry.remove(); // Close the toast
                  },
                  icon: Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay?.insert(entry);

    Future.delayed(Duration(seconds: 3), () {
      entry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create an Account'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(hintText: 'First Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(hintText: 'Last Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(hintText: 'Phone Number'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => signUserUp(context),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

extension on PostgrestResponse {
  get error => null;
}

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crypto/crypto.dart'; // For password hashing
import 'dart:convert'; // For utf8.encode

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final supabase = Supabase.instance.client; // Get the Supabase client

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  Positioned(
                    right: -10,
                    bottom: -10,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Color(0xFFCA7C5C)),
                      onPressed: () {
                        // Trigger image selection or camera capture
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              _buildTextField(
                controller: firstNameController,
                label: 'First Name',
                icon: Icons.person,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: lastNameController,
                label: 'Last Name',
                icon: Icons.person,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: emailController,
                label: 'E-Mail',
                icon: Icons.email,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: phoneController,
                label: 'Phone No',
                icon: Icons.phone,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: passwordController,
                label: 'Password',
                icon: Icons.lock,
                obscureText: true,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await _saveProfile();
                },
                child: Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color(0xFFCA7C5C),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Delete account action
                },
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to save the profile information to Supabase
  Future<void> _saveProfile() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    // Ensure user is authenticated
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You need to be logged in to edit your profile.")),
      );
      return;
    }

    // Ensure no field is left empty
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required.")),
      );
      return;
    }

    try {
      // Hash the password using SHA-256 before storing it
      final hashedPassword = sha256.convert(utf8.encode(passwordController.text)).toString();

      // Update user profile in the Supabase table 'users'
      final response = await supabase
          .from('users')
          .update({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'phone_number': phoneController.text,
        'hashed_password': hashedPassword,
      }).eq('id', userId);

      if (response.error == null) {
        // Verify if the response contains data
        if (response.data != null && response.data.length > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Profile updated successfully!")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No data was updated. Please check your input.")),
          );
        }
      } else {
        // Handle error if present
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.error!.message}")),
        );
      }
    } catch (error) {
      // Catch any other error and display it
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${error.toString()}")),
      );
    }
  }

  // Utility function to build text fields with icons
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
  }
}

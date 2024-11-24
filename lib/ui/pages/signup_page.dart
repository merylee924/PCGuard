import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_project/ui/pages/theme.dart';

class SignUpPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  Future<void> signUserUp(BuildContext context) async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();

    if (email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty || username.isEmpty) {
      _showCustomToast(context, 'Please fill all fields.', Colors.orange, Icons.warning);
      return;
    }

    try {
      // Create a user with Supabase Auth
      final authResponse = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      // Check if the user has been created successfully
      if (authResponse.user != null) {
        final userId = authResponse.user!.id;  // Récupérer l'UUID de l'utilisateur créé

        // Insert additional user information into the 'users' table
        final response = await Supabase.instance.client
            .from('users')
            .insert({
          'id': userId,  // Insérer l'UUID généré par l'authentification
          'username': username,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phoneNumber,
        }).execute();

        if (response.error == null) {
          _showCustomToast(context, 'Account successfully created!', Colors.green, Icons.check_circle);

          // Redirect to the welcome page after account creation
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pushReplacementNamed('/welcome_page');
          });
        } else {
          _showCustomToast(context, 'Failed to insert user data: ${response.error!.message}', Colors.red, Icons.error);
        }
      } else {
        _showCustomToast(context, 'Failed to create user in Supabase Auth.', Colors.red, Icons.error);
      }
    } catch (e) {
      // Handle other errors
      _showCustomToast(context, 'Failed to create account: $e', Colors.red, Icons.error);
    }
  }

  void _showCustomToast(BuildContext context, String message, Color color, IconData icon) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        right: 20,
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
      backgroundColor: CustomTheme.lightTheme().scaffoldBackgroundColor,
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
            _buildTextField(firstNameController, 'First Name'),
            const SizedBox(height: 20),
            _buildTextField(lastNameController, 'Last Name'),
            const SizedBox(height: 20),
            _buildTextField(usernameController, 'Username'),
            const SizedBox(height: 20),
            _buildTextField(emailController, 'Email'),
            const SizedBox(height: 20),
            _buildTextField(phoneNumberController, 'Phone Number'),
            const SizedBox(height: 20),
            _buildTextField(passwordController, 'Password', obscureText: true),
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

  Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: CustomTheme.lightTheme().textTheme.bodyMedium?.color),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: CustomTheme.lightTheme().hintColor),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: CustomTheme.lightTheme().dividerColor!),
        ),
      ),
    );
  }
}

extension on PostgrestResponse {
  get error => null;
}

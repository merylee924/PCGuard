import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:test_project/ui/pages/theme.dart';
import '../../components/button.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.lightTheme(); // Utilisez lightTheme ou darkTheme selon votre besoin

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Titre de l'application
                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    'PC Surveillance',
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Description modifiée
                FadeInDown(
                  delay: const Duration(milliseconds: 400),
                  child: Text(
                    'Receive image captures if someone tries to access your PC.',
                    style: TextStyle(
                      color: theme.hintColor,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),

                // Bouton Sign In
                FadeInDown(
                  delay: const Duration(milliseconds: 600),
                  child: MyButton(
                    onTap: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    text: 'Sign in',
                    buttonColor: theme.buttonTheme.buttonColor ?? Colors.blue, // Défaut si null
                    textColor: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 20),

                // Bouton Create an Account
                FadeInDown(
                  delay: const Duration(milliseconds: 800),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: Text(
                      'Create an account',
                      style: TextStyle(
                        color: theme.primaryColor,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: theme.primaryColor),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 30.0,
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

extension on ButtonThemeData {
  get buttonColor => null;
}

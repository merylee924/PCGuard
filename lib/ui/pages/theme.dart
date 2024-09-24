import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF2D5DC),  // Light pink background
      primaryColor: const Color(0xFF734158),  // Dark purple for primary elements
      hintColor: const Color(0xFFC67F89),   // Accent color with soft red-pink tone
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF734158)), // Text with dark purple shade
        bodyMedium: TextStyle(color: Color(0xFF734158)),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFFFFFFF),  // White input field
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFB39084),   // Buttons with light beige-brown color
        textTheme: ButtonTextTheme.primary,
      ),
      dividerColor: const Color(0xFFD6BCA5),  // Divider color with light beige
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFF734158),  // Dark purple background
      primaryColor: const Color(0xFFF2D5DC),  // Light pink for primary elements
      hintColor: const Color(0xFFD6BCA5),    // Hint with soft beige
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFFF2D5DC)), // Text with light pink shade
        bodyMedium: TextStyle(color: Color(0xFFF2D5DC)),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF734158),  // Dark purple input field
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFC67F89),  // Buttons with soft red-pink
        textTheme: ButtonTextTheme.primary,
      ),
      dividerColor: const Color(0xFFD6BCA5),  // Divider with light beige
    );
  }
}

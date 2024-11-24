import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),  // Fond blanc
      primaryColor: const Color(0xFF000000),  // Noir pour les éléments principaux
      hintColor: const Color(0xFFB0B0B0),     // Gris clair pour les indices
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF000000)), // Texte noir
        bodyMedium: TextStyle(color: Color(0xFF000000)),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFFFFFFF),  // Champ de saisie blanc
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFB0B0B0),   // Boutons gris
        textTheme: ButtonTextTheme.primary,
      ),
      dividerColor: const Color(0xFFB0B0B0),  // Couleur de la ligne de séparation en gris
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFF121212),  // Fond noir
      primaryColor: const Color(0xFFB0B0B0),  // Gris clair pour les éléments principaux
      hintColor: const Color(0xFF787878),     // Gris moyen pour les indices
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFFFFFFFF)), // Texte blanc
        bodyMedium: TextStyle(color: Color(0xFFFFFFFF)),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF212121),  // Fond de champ de saisie gris foncé
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF787878),  // Boutons gris moyen
        textTheme: ButtonTextTheme.primary,
      ),
      dividerColor: const Color(0xFF787878),  // Ligne de séparation gris moyen
    );
  }
}

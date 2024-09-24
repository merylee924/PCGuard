import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Color? textColor;  // Paramètre pour la couleur du texte
  final Color? hintColor;  // Paramètre pour la couleur de l'indice
  final Color? fillColor;  // Paramètre pour la couleur de remplissage
  final Color? enabledBorderColor;  // Paramètre pour la couleur de la bordure activée
  final Color? focusedBorderColor;  // Paramètre pour la couleur de la bordure au focus

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.textColor = Colors.black,  // Couleur par défaut du texte
    this.hintColor = Colors.grey,  // Couleur par défaut de l'indice
    this.fillColor = Colors.white,  // Couleur par défaut de remplissage
    this.enabledBorderColor = Colors.grey,  // Couleur par défaut de la bordure activée
    this.focusedBorderColor = Colors.grey,  // Couleur par défaut de la bordure au focus
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor!),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor!),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: fillColor,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),
        ),
        style: TextStyle(color: textColor),
      ),
    );
  }
}

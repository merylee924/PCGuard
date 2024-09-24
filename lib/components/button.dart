import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;  // Paramètre pour le texte du bouton
  final Color? buttonColor;  // Paramètre pour la couleur du bouton
  final Color? textColor;  // Paramètre pour la couleur du texte

  const MyButton({
    super.key,
    required this.onTap,
    this.text = "Sign in",  // Texte par défaut
    this.buttonColor = const Color(0xFFC49D83),  // Couleur par défaut du bouton
    this.textColor = Colors.white,  // Couleur par défaut du texte
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: buttonColor,  // Utilisation de la couleur personnalisée du bouton
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,  // Utilisation du texte personnalisé
            style: TextStyle(
              color: textColor,  // Utilisation de la couleur personnalisée du texte
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

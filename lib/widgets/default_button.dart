import 'package:flutter/material.dart';
import 'package:medmate/constants/colors.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const DefaultButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shadowColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 5, // Shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primary_text_color,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medmate/constants/colors.dart';

class CustomHeaderWidget extends StatelessWidget {
  final String title;

  const CustomHeaderWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: primary_text_color,
        ),
      ),
    );
  }
}

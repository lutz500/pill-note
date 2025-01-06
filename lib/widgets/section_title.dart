import 'package:flutter/material.dart';
import 'package:medmate/constants/colors.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;

  const SectionTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primary_text_color,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medmate/constants/colors.dart';

class SelectTypeWidget extends StatelessWidget {
  final String label;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectTypeWidget({
    Key? key,
    required this.label,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? selection_color
                  : seconday_color, // Highlight if selected
              boxShadow: [circle_box_shadow],
              border: Border.all(
                color: isSelected
                    ? selection_color
                    : Colors.transparent, // Border for selected
                width: 3,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                imagePath,
                height: 30,
              ),
            ),
          ),
          Text(label),
        ],
      ),
    );
  }
}

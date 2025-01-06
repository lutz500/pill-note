import 'package:flutter/material.dart';
import 'package:medmate/constants/colors.dart';

class AddPillHeaderWidget extends StatelessWidget {
  // Updated constructor to accept 'name'
  const AddPillHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: primary_text_color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Align left for the back button
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: primary_color, // Set arrow color to primary_color
              ),
              onPressed: () {
                // Go back to the previous screen
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Pill", // Displaying the title
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: primary_color,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Go back to the previous screen
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: seconday_color,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(1, 3),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/dont_add_pill.png',
                    height: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

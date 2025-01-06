import 'package:flutter/material.dart';
import 'package:medmate/constants/colors.dart';

class WelcomeCustomHeaderWidget extends StatelessWidget {
  // Add a required `name` parameter
  final String name;
  final VoidCallback onAddPill; // Callback for adding a card
  final VoidCallback onAddSupplement; // Callback for adding a supplement

  // Update the constructor to require the `name` parameter
  const WelcomeCustomHeaderWidget(
      {Key? key,
      required this.name,
      required this.onAddPill,
      required this.onAddSupplement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: primary_text_color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Guten Morgen",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: primary_color,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 20),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primary_color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Right side: Image container
            Row(
              children: [
                GestureDetector(
                  onTap: onAddPill,
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
                        'assets/images/drug.png',
                        height: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: onAddSupplement,
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
                        'assets/images/supplements.png',
                        height: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medmate/constants/colors.dart';

class PillCardWidget extends StatelessWidget {
  final int id;
  final String text;
  final String interval;
  final String time;
  final String pillType;
  final String? pillState;
  final String? log_time;
  final Function(int) onPillDelete;
  final Function(int) onTap;

  const PillCardWidget({
    Key? key,
    required this.text,
    required this.interval,
    required this.time,
    required this.pillType,
    required this.id,
    required this.pillState,
    required this.log_time,
    required this.onPillDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(id);
      },
      onLongPress: () {
        onPillDelete(id);
      },
      child: Card(
        elevation: 10,
        color: primary_color,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: seconday_color,
                  boxShadow: [circle_box_shadow],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    pillType == "pill"
                        ? "assets/images/drug.png"
                        : "assets/images/supplements.png",
                    height: 30,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primary_text_color),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "$interval - $time",
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: primary_text_color),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15),
              if (log_time != null && pillState == "taken")
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: seconday_color,
                    boxShadow: [circle_box_shadow],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Column(
                        //   children: [
                        //     Text("Taken at:", // Display the text "Taken at:"
                        //         style: const TextStyle(
                        //             fontSize: 10,
                        //             fontWeight: FontWeight.bold,
                        //             color: primary_text_color)),
                        //     Text(
                        //       logTimeGetDate(
                        //           log_time!), // Display the date in one line
                        //       style: const TextStyle(
                        //           fontSize: 10,
                        //           fontWeight: FontWeight.bold,
                        //           color: primary_text_color),
                        //     ),
                        //     Text(
                        //       logTimeGetTime(
                        //           log_time!), // Display the time in another line
                        //       style: const TextStyle(
                        //           fontSize: 10,
                        //           fontWeight: FontWeight.bold,
                        //           color: primary_text_color),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(width: 15),
                        // Display a green checkmark if the pill is taken
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

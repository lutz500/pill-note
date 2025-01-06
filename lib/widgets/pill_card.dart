import 'package:flutter/material.dart';
import 'package:medmate/constants/colors.dart';

class PillCardWidget extends StatefulWidget {
  final int id;
  final String text;
  final String interval;
  final String time;
  final String pillType;
  final Function(int) onPillDelete;

  const PillCardWidget({
    Key? key,
    required this.text,
    required this.interval,
    required this.time,
    required this.pillType,
    required this.id,
    required this.onPillDelete,
  }) : super(key: key);

  @override
  _PillCardWidgetState createState() => _PillCardWidgetState();
}

class _PillCardWidgetState extends State<PillCardWidget> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = !isTapped; // Toggle the state on tap
        });
      },
      onLongPress: () {
        widget.onPillDelete(widget.id);
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
                    widget.pillType == "pill"
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
                      widget.text,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primary_text_color),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "${widget.interval} - ${widget.time}",
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
              // Add the green checkmark here, shown if tapped
              if (isTapped)
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 30,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

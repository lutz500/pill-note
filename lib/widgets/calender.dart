import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart'; // Keep this import

class DatePickerWidget extends StatelessWidget {
  final DateTime focusedDate;
  final Function(DateTime) onDateChange;

  const DatePickerWidget({
    Key? key,
    required this.focusedDate,
    required this.onDateChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: EasyDateTimeLinePicker(
          focusedDate: focusedDate,
          daySeparatorPadding: 10,
          firstDate: DateTime(2024, 3, 18),
          lastDate: DateTime(2030, 3, 18),
          headerOptions: HeaderOptions(headerType: HeaderType.none),
          onDateChange: onDateChange,
        ),
      ),
    );
  }
}

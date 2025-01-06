import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:medmate/constants/colors.dart';

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
        child: EasyTheme(
          data: EasyTheme.of(context).copyWith(
            dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return selection_color;
              } else if (states.contains(WidgetState.disabled)) {
                return Colors.grey.shade100;
              }
              return Colors.white;
            }),
            currentDayBackgroundColor:
                WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return selection_color;
              } else if (states.contains(WidgetState.disabled)) {
                return Colors.grey.shade100;
              }
              return Colors.white;
            }),
          ),
          child: EasyDateTimeLinePicker(
            monthYearPickerOptions: MonthYearPickerOptions(
              initialCalendarMode: EasyDatePickerMode.month,
              cancelText: 'Cancel',
              confirmText: 'Confirm',
            ),
            focusedDate: focusedDate,
            daySeparatorPadding: 10,
            firstDate: DateTime(2024, 3, 18),
            lastDate: DateTime(2030, 3, 18),
            headerOptions: HeaderOptions(headerType: HeaderType.picker),
            onDateChange: onDateChange,
          ),
        ),
      ),
    );
  }
}

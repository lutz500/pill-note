import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

// Helper function to show an alert dialog
void showAlertDialog(BuildContext context, String message) {
  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Alert'),
      content: Text(message), // Display dynamic message
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

String formatDuration(Duration duration) {
  return '${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}';
}

String getToday() {
  return DateFormat('yyyy-MM-dd').format(DateTime.now());
}

String formatDateTimeToDate(DateTime dateTime) {
  return DateFormat('MM/dd/yyyy').format(dateTime);
}

String formatDateTimeToDatetime(DateTime dateTime) {
  return DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
}

String formatLogTime(String logtime) {
  // Split the input string into the date part and the time part
  List<String> parts = logtime.split(' ');

  // If the input is correctly formatted with a space between date and time
  if (parts.length == 2) {
    return '${parts[0]}\n${parts[1]}'; // Add a new line between date and time
  } else {
    return logtime; // Return the original logtime if the format is incorrect
  }
}

// Format the log time by splitting it at the first space into date and time
String logTimeGetDate(String logtime) {
  List<String> parts = logtime.split(' ');
  if (parts.isNotEmpty) {
    return parts[0]; // Return the date part
  }
  return logtime; // Return original logtime if there's no space
}

String logTimeGetTime(String logtime) {
  List<String> parts = logtime.split(' ');
  if (parts.length > 1) {
    return parts[1]; // Return the time part
  }
  return logtime; // Return original logtime if there's no time part
}

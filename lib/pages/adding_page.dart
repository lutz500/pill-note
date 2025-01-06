import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medmate/constants/colors.dart';
import 'package:medmate/helper.dart';
import 'package:medmate/storage/database_service.dart';
import 'package:medmate/widgets/add_pill_header.dart';
import 'package:medmate/widgets/custom_text_field.dart';
import 'package:medmate/widgets/default_button.dart';
import 'package:medmate/widgets/section_title.dart';
import 'package:medmate/widgets/selectType.dart';
import 'package:medmate/widgets/welcome_header.dart';

class AddPillPage extends StatefulWidget {
  final String pillType; // 'pill' or 'supplement'

  const AddPillPage({Key? key, required this.pillType}) : super(key: key);

  @override
  _AddPillPageState createState() => _AddPillPageState();
}

class _AddPillPageState extends State<AddPillPage> {
  final DatabaseService _databaseService = DatabaseService.instance;
  final TextEditingController _nameController = TextEditingController();

  String _selectedType = '';
  String _selectedInterval = '';
  Duration duration = const Duration(hours: 7, minutes: 00);

  void _savePill() async {
    final name = _nameController.text;

    if (name.isNotEmpty &&
        duration.toString().isNotEmpty &&
        _selectedType.isNotEmpty &&
        _selectedInterval.isNotEmpty) {
      // Add pill or supplement to the database
      _databaseService.addPill(
        name,
        _selectedInterval,
        formatDuration(duration),
        _selectedType,
      );

      // Go back to the previous screen
      Navigator.pop(context);
    } else {
      // Show an error if fields are empty
      showAlertDialog(context, 'Please fill in all fields.');
    }
  }

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts
  // a CupertinoTimerPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AddPillHeaderWidget(),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                SectionTitleWidget(title: "Name:"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomTextFieldWidget(
                    controller: _nameController,
                    labelText: 'Name',
                    hintText: 'Enter your name',
                  ),
                ),
                SectionTitleWidget(title: "Type:"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectTypeWidget(
                      label: 'Pill',
                      imagePath: 'assets/images/drug.png',
                      isSelected:
                          _selectedType == 'pill', // Check if pill is selected
                      onTap: () {
                        setState(() {
                          _selectedType =
                              'pill'; // Update selected type to 'pill'
                        });
                      },
                    ),
                    SizedBox(width: 15),
                    SelectTypeWidget(
                      label: 'Supplement',
                      imagePath: 'assets/images/supplements.png',
                      isSelected: _selectedType ==
                          'supplement', // Check if supplement is selected
                      onTap: () {
                        setState(() {
                          _selectedType =
                              'supplement'; // Update selected type to 'supplement'
                        });
                      },
                    ),
                  ],
                ),
                SectionTitleWidget(title: "Interval:"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectTypeWidget(
                      label: 'Daily',
                      imagePath: 'assets/images/one_day.png',
                      isSelected: _selectedInterval ==
                          'daily', // Check if pill is selected
                      onTap: () {
                        setState(() {
                          _selectedInterval =
                              'daily'; // Update selected type to 'pill'
                        });
                      },
                    ),
                    SizedBox(width: 15),
                    SelectTypeWidget(
                      label: 'Weekly',
                      imagePath: 'assets/images/seven_days.png',
                      isSelected: _selectedInterval ==
                          'weekly', // Check if supplement is selected
                      onTap: () {
                        setState(() {
                          _selectedInterval =
                              'weekly'; // Update selected type to 'supplement'
                        });
                      },
                    ),
                  ],
                ),
                SectionTitleWidget(title: "Time:"),
                CupertinoButton(
                  // Display a CupertinoTimerPicker with hour/minute mode.
                  onPressed: () => _showDialog(
                    CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hm,
                      initialTimerDuration: duration,
                      // This is called when the user changes the timer's
                      // duration.
                      onTimerDurationChanged: (Duration newDuration) {
                        setState(() => duration = newDuration);
                      },
                    ),
                  ),
                  child: Text(
                    formatDuration(duration),
                    style: const TextStyle(
                        fontSize: 22.0,
                        color: primary_text_color,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                DefaultButton(onPressed: _savePill, buttonText: "Save")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + this.substring(1);
  }
}

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
      _databaseService.addPill(
        name,
        _selectedInterval,
        formatDuration(duration),
        _selectedType,
      );

      Navigator.pop(context);
    } else {
      showAlertDialog(context, 'Please fill in all fields.');
    }
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
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
                      isSelected: _selectedType == 'pill',
                      onTap: () {
                        setState(() {
                          _selectedType = 'pill';
                        });
                      },
                    ),
                    SizedBox(width: 15),
                    SelectTypeWidget(
                      label: 'Supplement',
                      imagePath: 'assets/images/supplements.png',
                      isSelected: _selectedType == 'supplement',
                      onTap: () {
                        setState(() {
                          _selectedType = 'supplement';
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
                      isSelected: _selectedInterval == 'daily',
                      onTap: () {
                        setState(() {
                          _selectedInterval = 'daily';
                        });
                      },
                    ),
                    SizedBox(width: 15),
                    SelectTypeWidget(
                      label: 'Weekly',
                      imagePath: 'assets/images/seven_days.png',
                      isSelected: _selectedInterval == 'weekly',
                      onTap: () {
                        setState(() {
                          _selectedInterval = 'weekly';
                        });
                      },
                    ),
                  ],
                ),
                SectionTitleWidget(title: "Time:"),
                CupertinoButton(
                  onPressed: () => _showDialog(
                    CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hm,
                      initialTimerDuration: duration,
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

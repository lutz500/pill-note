import 'package:flutter/material.dart';
import 'package:medmate/constants/colors.dart';
import 'package:medmate/storage/database_service.dart';
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
  final TextEditingController _timeController = TextEditingController();

  String _selectedType = '';
  String _selectedInterval = ''; // Track the selected type (pill or supplement)

  void _savePill() async {
    final name = _nameController.text;
    final time = _timeController.text;

    if (name.isNotEmpty &&
        time.isNotEmpty &&
        _selectedType.isNotEmpty &&
        _selectedInterval.isNotEmpty) {
      // Add pill or supplement to the database
      _databaseService.addPill(
        name,
        _selectedInterval,
        time,
        _selectedType,
      );

      // Go back to the previous screen
      Navigator.pop(context);
    } else {
      // Show an error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ${widget.pillType.capitalize()}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Type:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primary_text_color,
                      )),
                ),
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Interval:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primary_text_color,
                      )),
                ),
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
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _timeController,
                  decoration: InputDecoration(labelText: 'Time'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _savePill,
                  child: Text('Save'),
                ),
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

import 'package:flutter/material.dart';
import 'package:medmate/constants/colors.dart';
import 'package:medmate/pages/adding_page.dart';
import 'package:medmate/widgets/welcome_header.dart';
import 'package:medmate/widgets/calender.dart';
import 'package:medmate/widgets/custom_header.dart';
import 'package:medmate/widgets/pill_section.dart';
import 'package:medmate/storage/database_service.dart';
import 'package:medmate/storage/models/pill.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPage createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<String> PillCardWidgetTexts = [];
  List<Map<String, dynamic>> pills = [];
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadPills();
  }

  Future<void> _loadPills() async {
    pills = await _databaseService.getPills();
    setState(() {});
  }

  void _addPill() async {
    // Navigate to AddPillPage for adding a pill and await the result
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPillPage(pillType: 'pill'), // Pass 'pill'
      ),
    );
    _loadPills(); // Reload pills after the user returns from the AddPillPage
  }

  void _deletePill(int id) async {
    _databaseService.deletePill(id);
    _loadPills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeCustomHeaderWidget(
                name: "Lutz", onAddPill: _addPill, onAddSupplement: _addPill),
            DatePickerWidget(
              focusedDate: _selectedDate,
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
            CustomHeaderWidget(title: "Pills"),
            PillSectionWidget(
              pillData: pills
                  .where((pill) => Pill.fromMap(pill).pill_type == "pill")
                  .toList(),
              onPillDelete: _deletePill,
            ),
            CustomHeaderWidget(title: "Supplements"),
            PillSectionWidget(
              pillData: pills
                  .where((pill) => Pill.fromMap(pill).pill_type == "supplement")
                  .toList(),
              onPillDelete: _deletePill,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medmate/constants/colors.dart';
import 'package:medmate/helper.dart';
import 'package:medmate/pages/adding_page.dart';
import 'package:medmate/storage/models/pill_data.dart';
import 'package:medmate/widgets/welcome_header.dart';
import 'package:medmate/widgets/calender.dart';
import 'package:medmate/widgets/custom_header.dart';
import 'package:medmate/widgets/pill_section.dart';
import 'package:medmate/storage/database_service.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPage createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<Map<String, dynamic>> pillData = [];
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _getPillLogsByDate(_selectedDate);
  }

  void _getPillLogsByDate(DateTime date) async {
    pillData =
        await _databaseService.getPillLogsByDate(formatDateTimeToDate(date));
    setState(() {});
  }

  Future<void> _loadPillData() async {
    _getPillLogsByDate(_selectedDate);
    setState(() {});
  }

  void _addPill() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPillPage(pillType: 'pill'),
      ),
    );
    _getPillLogsByDate(_selectedDate);
  }

  void _deletePill(int id) async {
    _databaseService.deletePill(id);
    _loadPillData();
  }

  void _togglePillAction(int id) async {
    var pill_logs = await _databaseService.getPillLogs(
        id, formatDateTimeToDate(_selectedDate));

    if (pill_logs.isEmpty) {
      _databaseService.addPillLog(
          id, "taken", formatDateTimeToDate(_selectedDate));
    } else {
      _databaseService.deletePillLog(id, formatDateTimeToDate(_selectedDate));
    }

    _loadPillData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeCustomHeaderWidget(name: "Lutz", onAddPill: _addPill),
            DatePickerWidget(
              focusedDate: _selectedDate,
              onDateChange: (date) {
                _getPillLogsByDate(date);

                setState(() {
                  _selectedDate = date;
                });
              },
            ),
            CustomHeaderWidget(title: "Pills"),
            PillSectionWidget(
              pillData: pillData
                  .where((pill) => PillData.fromMap(pill).pill_type == "pill")
                  .toList(),
              onPillDelete: _deletePill,
              onTap: _togglePillAction,
            ),
            CustomHeaderWidget(title: "Supplements"),
            PillSectionWidget(
              pillData: pillData
                  .where((pill) =>
                      PillData.fromMap(pill).pill_type == "supplement")
                  .toList(),
              onPillDelete: _deletePill,
              onTap: _togglePillAction,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medmate/storage/models/pill_data.dart';
import 'package:medmate/widgets/pill_card.dart'; // Assuming PillCardWidget is imported
import 'package:medmate/storage/models/pill.dart';

class PillSectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> pillData;
  final Function(int) onPillDelete;
  final Function(int) onTap;

  const PillSectionWidget(
      {super.key,
      required this.pillData,
      required this.onPillDelete,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          itemCount: pillData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: PillCardWidget(
                  id: PillData.fromMap(pillData[index]).id,
                  pillType: PillData.fromMap(pillData[index]).pill_type,
                  text: PillData.fromMap(pillData[index]).name,
                  interval: PillData.fromMap(pillData[index]).frequency,
                  time: PillData.fromMap(pillData[index]).time,
                  pillState: PillData.fromMap(pillData[index]).action,
                  log_time: PillData.fromMap(pillData[index]).logtime,
                  onPillDelete: onPillDelete,
                  onTap: onTap),
            );
          },
        ),
      ],
    );
  }
}

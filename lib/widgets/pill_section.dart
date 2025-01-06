import 'package:flutter/material.dart';
import 'package:medmate/widgets/pill_card.dart'; // Assuming PillCardWidget is imported
import 'package:medmate/storage/models/pill.dart';

class PillSectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> pillData;
  final Function(int) onPillDelete;

  const PillSectionWidget(
      {super.key, required this.pillData, required this.onPillDelete});

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
                id: Pill.fromMap(pillData[index]).id,
                pillType: Pill.fromMap(pillData[index]).pill_type,
                text: Pill.fromMap(pillData[index]).name,
                interval: Pill.fromMap(pillData[index]).frequency,
                time: Pill.fromMap(pillData[index]).time,
                onPillDelete: onPillDelete,
              ),
            );
          },
        ),
      ],
    );
  }
}

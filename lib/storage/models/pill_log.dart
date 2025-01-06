class PillLog {
  final int id;
  final int pillId;
  final DateTime date;
  final bool taken;

  PillLog(
      {required this.id,
      required this.pillId,
      required this.date,
      required this.taken});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'pillId': pillId,
      'date': date.toIso8601String(),
      'taken': taken ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'PillLog{id: $id, pillId: $pillId, date: $date, taken: $taken}';
  }
}

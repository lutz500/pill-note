class PillLog {
  final int id;
  final int pillId;
  final String logtime;
  final String action;

  PillLog(
      {required this.id,
      required this.pillId,
      required this.logtime,
      required this.action});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'pillId': pillId,
      'logtime': logtime,
      'taken': action,
    };
  }

  factory PillLog.fromMap(Map<String, dynamic> map) {
    return PillLog(
      id: map['id'],
      pillId: map['pillId'],
      logtime: map['logtime'],
      action: map['action'],
    );
  }

  @override
  String toString() {
    return 'PillLog{id: $id, pillId: $pillId, date: $logtime, action: $action}';
  }
}

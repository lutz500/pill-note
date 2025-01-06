class PillData {
  final int id;
  final String? logtime;
  final String? action;
  final String name;
  final String frequency;
  final String time;
  final String pill_type;

  PillData(
      {required this.id,
      required this.logtime,
      required this.action,
      required this.name,
      required this.frequency,
      required this.time,
      required this.pill_type});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'logtime': logtime,
      'taken': action,
      'name': name,
      'frequency': frequency,
      'time': time,
      'pill_type': pill_type,
    };
  }

  factory PillData.fromMap(Map<String, dynamic> map) {
    return PillData(
      id: map['id'],
      logtime: map['logtime'],
      action: map['action'],
      name: map['name'],
      frequency: map['frequency'],
      time: map['time'],
      pill_type: map['pill_type'],
    );
  }
}

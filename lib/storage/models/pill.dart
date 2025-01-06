class Pill {
  final int id;
  final String name;
  final String frequency;
  final String time;
  final String pill_type;

  Pill({
    required this.id,
    required this.name,
    required this.frequency,
    required this.time,
    required this.pill_type,
  });

  factory Pill.fromMap(Map<String, dynamic> map) {
    return Pill(
      id: map['id'],
      name: map['name'],
      frequency: map['frequency'],
      time: map['time'],
      pill_type: map['pill_type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'frequency': frequency,
      'time': time,
      'pill_type': pill_type,
    };
  }
}

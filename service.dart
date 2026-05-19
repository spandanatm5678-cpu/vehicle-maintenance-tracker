class Service {
  int? id;
  int vehicleId;
  String type;
  String date;

  Service({
    this.id,
    required this.vehicleId,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'type': type,
      'date': date,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'],
      vehicleId: map['vehicleId'],
      type: map['type'],
      date: map['date'],
    );
  }
}
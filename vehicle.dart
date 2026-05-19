class Vehicle {
  int? id;
  String name;
  String number;

  Vehicle({this.id, required this.name, required this.number});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      name: map['name'],
      number: map['number'],
    );
  }
}
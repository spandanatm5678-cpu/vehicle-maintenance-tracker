class Fuel {
  final int? id;
  final int vehicleId;
  final double fuel;       // liters
  final double distance;   // km
  final double mileage;    // km/l
  final double cost;
  final String date;

  Fuel({
    this.id,
    required this.vehicleId,
    required this.fuel,
    required this.distance,
    required this.mileage,
    required this.cost,
    required this.date,
  });

  // Convert object → Map (for database insert)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'fuel': fuel,
      'distance': distance,
      'mileage': mileage,
      'cost': cost,
      'date': date,
    };
  }

  // Convert Map → object (from database)
  factory Fuel.fromMap(Map<String, dynamic> map) {
    return Fuel(
      id: map['id'],
      vehicleId: map['vehicleId'],
      fuel: map['fuel'],
      distance: map['distance'],
      mileage: map['mileage'],
      cost: map['cost'] ?? 0.0,
      date: map['date'],
    );
  }
}
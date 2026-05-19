import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class AddFuelScreen extends StatefulWidget {
  final Map<String, dynamic> vehicle;

  const AddFuelScreen({super.key, required this.vehicle});

  @override
  State<AddFuelScreen> createState() => _AddFuelScreenState();
}

class _AddFuelScreenState extends State<AddFuelScreen> {
  final db = DatabaseHelper.instance;

  final fuelController = TextEditingController();
  final distanceController = TextEditingController();

  List<Map<String, dynamic>> fuelList = [];

  @override
  void initState() {
    super.initState();
    loadFuel();
  }

  void loadFuel() async {
    final data = await db.getFuel(widget.vehicle['id']);
    setState(() {
      fuelList = data;
    });
  }

  void saveFuel() async {
    double fuel = double.tryParse(fuelController.text) ?? 0;
    double distance = double.tryParse(distanceController.text) ?? 0;

    if (fuel == 0 || distance == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid values")),
      );
      return;
    }

    double mileage = distance / fuel;

    await db.insertFuel({
      'vehicleId': widget.vehicle['id'],
      'fuel': fuel,
      'distance': distance,
      'mileage': mileage,
      'date': DateTime.now().toString(),
    });

    fuelController.clear();
    distanceController.clear();

    loadFuel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fuel - ${widget.vehicle['name']}"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: fuelController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Fuel (Litres)",
                  ),
                ),
                TextField(
                  controller: distanceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Distance (KM)",
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: saveFuel,
                  child: const Text("Save Fuel"),
                ),
              ],
            ),
          ),

          Expanded(
            child: fuelList.isEmpty
                ? const Center(child: Text("No Fuel Records"))
                : ListView.builder(
              itemCount: fuelList.length,
              itemBuilder: (context, index) {
                final f = fuelList[index];

                return Card(
                  child: ListTile(
                    title: Text(
                      "Mileage: ${(f['mileage'] ?? 0).toStringAsFixed(2)} km/L",
                    ),
                    subtitle: Text(
                      "Fuel: ${f['fuel']}L | Distance: ${f['distance']}km",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
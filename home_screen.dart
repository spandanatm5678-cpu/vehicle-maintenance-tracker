import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import 'add_vehicle.dart';
import 'add_service.dart';
import 'add_fuel.dart';

// NEW SCREENS
import 'expense_chart.dart';
import 'document_screen.dart';
import 'garage_finder.dart';
import 'ai_suggestion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = DatabaseHelper.instance;
  List<Map<String, dynamic>> vehicles = [];

  @override
  void initState() {
    super.initState();
    loadVehicles();
  }

  Future<void> loadVehicles() async {
    final data = await db.getVehicles();
    setState(() {
      vehicles = data;
    });
  }

  Future<void> goToAddVehicle() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddVehicleScreen()),
    );
    loadVehicles();
  }

  /// 🔥 OPTIONS MENU (UPDATED WITH NEW FEATURES)
  void openOptions(Map<String, dynamic> vehicle) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vehicle['name'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              /// SERVICE
              ListTile(
                leading: const Icon(Icons.build, color: Colors.blue),
                title: const Text("Service History"),
                onTap: () async {
                  Navigator.pop(context);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddServiceScreen(vehicle: vehicle),
                    ),
                  );
                  loadVehicles();
                },
              ),

              /// FUEL
              ListTile(
                leading: const Icon(Icons.local_gas_station, color: Colors.green),
                title: const Text("Fuel Entry"),
                onTap: () async {
                  Navigator.pop(context);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddFuelScreen(vehicle: vehicle),
                    ),
                  );
                },
              ),

              /// 📊 EXPENSE CHART
              ListTile(
                leading: const Icon(Icons.bar_chart, color: Colors.orange),
                title: const Text("Expense Chart"),
                onTap: () async {
                  Navigator.pop(context);
                  final data = await db.getFuel(vehicle['id']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ExpenseChart(data: data),
                    ),
                  );
                },
              ),

              /// 📷 DOCUMENTS
              ListTile(
                leading: const Icon(Icons.image, color: Colors.purple),
                title: const Text("Upload Bills"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DocumentScreen(),
                    ),
                  );
                },
              ),

              /// 📍 GARAGE FINDER
              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.red),
                title: const Text("Find Garage"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GarageFinder(),
                    ),
                  );
                },
              ),

              /// 🤖 AI SUGGESTION
              ListTile(
                leading: const Icon(Icons.smart_toy, color: Colors.teal),
                title: const Text("AI Suggestion"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AiSuggestion(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Tracker'),
        centerTitle: true,
      ),

      body: vehicles.isEmpty
          ? const Center(
        child: Text(
          "No Vehicles Added",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final v = vehicles[index];

          return Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.directions_car,
                    color: Colors.blue),
                title: Text(
                  v['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(v['number']),
                trailing:
                const Icon(Icons.arrow_forward_ios, size: 16),

                /// OPEN OPTIONS
                onTap: () => openOptions(v),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: goToAddVehicle,
        child: const Icon(Icons.add),
      ),
    );
  }
}
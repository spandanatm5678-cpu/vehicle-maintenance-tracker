import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class AddServiceScreen extends StatefulWidget {
  final dynamic vehicle; // ✅ receive vehicle

  const AddServiceScreen({super.key, required this.vehicle});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final db = DatabaseHelper.instance;

  List services = [];

  final typeController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadServices();
  }

  void loadServices() async {
    final data = await db.getServices(widget.vehicle['id']);
    setState(() {
      services = data;
    });
  }

  void addService() async {
    if (typeController.text.trim().isEmpty ||
        dateController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter all fields")),
      );
      return;
    }

    await db.insertService({
      'vehicleId': widget.vehicle['id'],
      'type': typeController.text.trim(),
      'date': dateController.text.trim(),
    });

    typeController.clear();
    dateController.clear();

    loadServices(); // refresh list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle['name']),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(
                  controller: typeController,
                  decoration: const InputDecoration(
                    labelText: "Service Type",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: "Date",
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: addService,
                  child: const Text("Add Service"),
                ),
              ],
            ),
          ),

          const Divider(),

          Expanded(
            child: services.isEmpty
                ? const Center(child: Text("No Services Added"))
                : ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                final s = services[index];
                return Card(
                  child: ListTile(
                    title: Text(s['type']),
                    subtitle: Text(s['date']),
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
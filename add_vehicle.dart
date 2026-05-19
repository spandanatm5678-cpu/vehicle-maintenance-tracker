import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final db = DatabaseHelper.instance;

  final nameController = TextEditingController();
  final numberController = TextEditingController();

  void saveVehicle() async {
    if (nameController.text.trim().isEmpty ||
        numberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter all fields")),
      );
      return;
    }

    await db.insertVehicle({
      'name': nameController.text.trim(),
      'number': numberController.text.trim(),
    });

    print("Vehicle Saved"); // debug

    Navigator.pop(context); // go back to home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Vehicle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Vehicle Name",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(
                labelText: "Vehicle Number",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveVehicle,
              child: const Text("Save Vehicle"),
            )
          ],
        ),
      ),
    );
  }
}
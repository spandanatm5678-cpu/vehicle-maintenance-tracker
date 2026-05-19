import 'package:flutter/material.dart';

class AiSuggestion extends StatelessWidget {

  String getSuggestion(double mileage, int days) {
    if (mileage < 30) {
      return "Low mileage ⚠️ Check engine or tyres";
    }

    if (days > 180) {
      return "Service overdue 🚗";
    }

    return "Vehicle is healthy ✅";
  }

  @override
  Widget build(BuildContext context) {
    double mileage = 28; // sample
    int days = 200;

    return Scaffold(
      appBar: AppBar(title: Text("AI Suggestion")),
      body: Center(
        child: Text(
          getSuggestion(mileage, days),
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
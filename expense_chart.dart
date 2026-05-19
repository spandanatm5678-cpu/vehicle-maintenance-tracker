import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpenseChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const ExpenseChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Chart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: data.isEmpty
            ? const Center(child: Text("No data available"))
            : LineChart(
          LineChartData(
            borderData: FlBorderData(show: true),
            titlesData: FlTitlesData(show: true),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                spots: data.map((e) {
                  return FlSpot(
                    (e['distance'] ?? 0).toDouble(),
                    (e['cost'] ?? 0).toDouble(),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
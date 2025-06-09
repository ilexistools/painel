import 'package:flutter/material.dart';
import '../charts/chart_bar.dart';

class ChartBarPage extends StatelessWidget {
  const ChartBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barras')),
      body: SimpleBarChart(
        data: [
          BarData(label: 'Jan', value: 5),
          BarData(label: 'Feb', value: 8),
        ],
      ),
    );
  }
}

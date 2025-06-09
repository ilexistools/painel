import 'package:flutter/material.dart';
import '../charts/chart_simple.dart';

class ChartLinePage extends StatelessWidget {
  const ChartLinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Linha')),
      body: const Center(child: SimpleLineChart()),
    );
  }
}

// charts/chart_simple.dart
// A simple line chart widget using the fl_chart package.

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// A simple line chart with customizable data points.
class SimpleLineChart extends StatelessWidget {
  /// The data points to plot.
  final List<FlSpot> spots;
  
  /// Creates a [SimpleLineChart].
  ///
  /// You can provide custom [spots] or rely on built-in sample data.
  const SimpleLineChart({
    Key? key,
    this.spots = const [
      FlSpot(0, 1),
      FlSpot(1, 1.5),
      FlSpot(2, 1.4),
      FlSpot(3, 3.4),
      FlSpot(4, 2),
      FlSpot(5, 2.2),
      FlSpot(6, 1.8),
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              dotData: FlDotData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
          ),
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }
}

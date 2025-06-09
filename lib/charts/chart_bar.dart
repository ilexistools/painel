// charts/chart_bar.dart
// A simple bar chart widget using the fl_chart package.

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Data model for a single bar.
class BarData {
  /// The label shown on the x-axis.
  final String label;
  /// The numeric value determining the bar height.
  final double value;

  BarData({required this.label, required this.value});
}

/// A bar chart that displays a list of [BarData].
class SimpleBarChart extends StatelessWidget {
  /// List of data entries to plot.
  final List<BarData> data;
  /// Whether to animate transitions.
  final bool animate;

  /// Creates a [SimpleBarChart].
  ///
  /// Requires [data] to render. Optionally animate with [animate].
  const SimpleBarChart({
    Key? key,
    required this.data,
    this.animate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine maximum Y value for chart scaling.
    final maxY = data.isNotEmpty
        ? data.map((d) => d.value).reduce(max) * 1.2
        : 0.0;

    return SizedBox(
      height: 250,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double index, TitleMeta meta) {
                  final label = data[index.toInt()].label;
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(label, style: const TextStyle(fontSize: 10)),
                  );
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(value.toStringAsFixed(0), style: const TextStyle(fontSize: 10)),
                  );
                },
                reservedSize: 40,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true),
          barGroups: data.asMap().entries.map((entry) {
            final index = entry.key;
            final d = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: d.value,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }).toList(),
        ),
        swapAnimationDuration:
            animate ? const Duration(milliseconds: 600) : Duration.zero,
      ),
    );
  }
}

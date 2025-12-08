import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardStockChart extends StatelessWidget {
  const DashboardStockChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Stock de Inventario",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        const labels = ["A", "B", "C", "D"];
                        if (value < 0 || value >= labels.length) return const SizedBox();
                        return Text(labels[value.toInt()]);
                      },
                    ),
                  ),
                ),
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [
                    BarChartRodData(toY: 130, color: Colors.deepPurple, width: 18)
                  ]),
                  BarChartGroupData(x: 1, barRods: [
                    BarChartRodData(toY: 95, color: Colors.deepPurple, width: 18)
                  ]),
                  BarChartGroupData(x: 2, barRods: [
                    BarChartRodData(toY: 110, color: Colors.deepPurple, width: 18)
                  ]),
                  BarChartGroupData(x: 3, barRods: [
                    BarChartRodData(toY: 80, color: Colors.deepPurple, width: 18)
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

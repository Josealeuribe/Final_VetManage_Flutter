import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardSalesChart extends StatelessWidget {
  const DashboardSalesChart({super.key});

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
          const Text("Ventas vs Compras",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          SizedBox(
            height: 240,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(drawVerticalLine: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, _) {
                        const months = ["Ene", "Feb", "Mar", "Abr", "Mun", "Jun"];
                        if (value < 0 || value >= months.length) return const SizedBox();
                        return Text(months[value.toInt()]);
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  // Compras (verde)
                  LineChartBarData(
                    color: Colors.green,
                    spots: const [
                      FlSpot(0, 4000),
                      FlSpot(1, 5000),
                      FlSpot(2, 3000),
                      FlSpot(3, 9000),
                      FlSpot(4, 4000),
                      FlSpot(5, 5000),
                    ],
                    isCurved: true,
                    barWidth: 3,
                  ),
                  // Ventas (azul)
                  LineChartBarData(
                    color: Colors.blue,
                    spots: const [
                      FlSpot(0, 2000),
                      FlSpot(1, 2500),
                      FlSpot(2, 1500),
                      FlSpot(3, 3500),
                      FlSpot(4, 2800),
                      FlSpot(5, 3200),
                    ],
                    isCurved: true,
                    barWidth: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

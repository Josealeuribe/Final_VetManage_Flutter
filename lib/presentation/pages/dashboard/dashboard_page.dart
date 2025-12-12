import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:v_manage/widgets/custom_appbar.dart';
import 'package:v_manage/widgets/custom_bottom_nav.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),

      backgroundColor: const Color(0xFFF5F7FA),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 0, // Dashboard siempre es el índice 0
        onTap: (i) {
          switch (i) {
            case 0:
              // Ya estás en Dashboard
              break;

            case 1:
              Navigator.pushReplacementNamed(context, "/traslados");
              break;

            case 2:
              Navigator.pushReplacementNamed(context, "/existencias");
              break;

            case 3:
              // "Más" se abre solo desde el CustomBottomNav
              break;
          }
        },
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dashboard",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "Bienvenido al panel de control de VManage",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 20),
            _buildStats(),

            const SizedBox(height: 20),
            _buildSalesChart(),

            const SizedBox(height: 20),
            _buildStockChart(),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------
  //                   MÉTRICAS SUPERIORES
  // -------------------------------------------------------
  Widget _buildStats() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [
        _statCard("Total Ventas", "\$48,574", "+12.5%", Colors.green),
        _statCard("Clientes", "1,234", "+8.2%", Colors.green),
        _statCard("Órdenes", "567", "-3.1%", Colors.red),
        _statCard("Productos", "892", "+15.3%", Colors.green),
      ],
    );
  }

  Widget _statCard(String title, String value, String change, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            change,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------
  //                     GRÁFICA DE LÍNEAS
  // -------------------------------------------------------
  Widget _buildSalesChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ventas vs Compras",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          "Ene",
                          "Feb",
                          "Mar",
                          "Abr",
                          "May",
                          "Jun",
                        ];
                        if (value < 0 || value > 5) return Container();
                        return Text(
                          months[value.toInt()],
                          style: const TextStyle(fontSize: 11),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 3,
                    spots: const [
                      FlSpot(0, 3000),
                      FlSpot(1, 4500),
                      FlSpot(2, 2000),
                      FlSpot(3, 5500),
                      FlSpot(4, 4800),
                      FlSpot(5, 6000),
                    ],
                  ),
                  LineChartBarData(
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    spots: const [
                      FlSpot(0, 2000),
                      FlSpot(1, 3500),
                      FlSpot(2, 3000),
                      FlSpot(3, 4000),
                      FlSpot(4, 3200),
                      FlSpot(5, 5000),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------
  //               GRÁFICA DE STOCK (BARRAS)
  // -------------------------------------------------------
  Widget _buildStockChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Stock de Inventario",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                barGroups: [
                  _bar(0, 100),
                  _bar(1, 80),
                  _bar(2, 120),
                  _bar(3, 90),
                  _bar(4, 70),
                ],
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const items = ["A", "B", "C", "D", "E"];
                        if (value < 0 || value > 4) return Container();
                        return Text(
                          items[value.toInt()],
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _bar(double x, double value) {
    return BarChartGroupData(
      x: x.toInt(),
      barRods: [
        BarChartRodData(
          toY: value,
          color: Colors.blue,
          width: 18,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
      ],
    );
  }
}

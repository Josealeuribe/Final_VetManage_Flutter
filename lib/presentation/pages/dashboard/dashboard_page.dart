import 'package:flutter/material.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/dashboard_cards.dart';
import 'widgets/dashboard_sales_chart.dart';
import 'widgets/dashboard_stock_chart.dart';
import 'widgets/dashboard_bottom_nav.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: DashboardHeader(),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 10),
            Text(
              "Dashboard",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Bienvenido al panel de control de VManage",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            SizedBox(height: 20),
            DashboardCards(),
            SizedBox(height: 20),
            DashboardSalesChart(),
            SizedBox(height: 20),
            DashboardStockChart(),
          ],
        ),
      ),

      bottomNavigationBar: const DashboardBottomNav(),
    );
  }
}

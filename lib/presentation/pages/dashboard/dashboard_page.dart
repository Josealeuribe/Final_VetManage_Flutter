import 'package:flutter/material.dart';
import 'package:project_end/shared/widgets/base_page.dart';
import 'widgets/dashboard_cards.dart';
import 'widgets/dashboard_sales_chart.dart';
import 'widgets/dashboard_stock_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Dashboard",
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 10),
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
    );
  }
}

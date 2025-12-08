import 'package:flutter/material.dart';

class DashboardCards extends StatelessWidget {
  const DashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      childAspectRatio: 1.4,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _metricCard("Total Ventas", "\$48,574", "+12,5%", Colors.green),
        _metricCard("Clientes", "1,234", "+8,2%", Colors.green),
        _metricCard("Órdenes", "567", "-3,1%", Colors.red),
        _metricCard("Productos", "892", "+15,3%", Colors.green),
      ],
    );
  }

  Widget _metricCard(String title, String value, String percentage, Color color) {
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
          Text(title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(
            percentage,
            style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

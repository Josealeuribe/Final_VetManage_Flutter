import 'package:flutter/material.dart';
import 'package:project_end/widgets/custom_appbar.dart';
import 'package:project_end/widgets/custom_bottom_nav.dart';

class ReportesPage extends StatelessWidget {
  const ReportesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF5F7FA),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3, // Dashboard siempre es el índice 0
        onTap: (i) {
          switch (i) {
            case 0:
              Navigator.pushReplacementNamed(context, "/dashboard");
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

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Reportes",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              "Reportes generales del sistema",
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),

            const SizedBox(height: 20),

            _reportItem("Reporte de Ventas", Icons.bar_chart, Colors.blue),
            const SizedBox(height: 12),
            _reportItem("Reporte de Compras", Icons.shopping_bag, Colors.green),
            const SizedBox(height: 12),
            _reportItem(
              "Reporte de Inventario",
              Icons.inventory,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _reportItem("Reporte de Clientes", Icons.people, Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _reportItem(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(.15),
            child: Icon(icon, size: 26, color: color),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

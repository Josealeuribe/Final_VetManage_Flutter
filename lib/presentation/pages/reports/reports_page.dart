import 'package:flutter/material.dart';
import 'package:project_end/shared/widgets/base_page.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Reportes",
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Reportes",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Panel de reportes y estadísticas"),
            const SizedBox(height: 20),

            Card(
              child: ListTile(
                title: const Text("Reporte de Ventas"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Acción para abrir reporte de ventas
                },
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Reporte de Inventario"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Acción para abrir reporte de inventario
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

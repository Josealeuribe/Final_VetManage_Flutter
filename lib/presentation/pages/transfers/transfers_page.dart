import 'package:flutter/material.dart';
import 'package:project_end/widgets/custom_appbar.dart';
import 'package:project_end/widgets/custom_bottom_nav.dart';

class TrasladosPage extends StatelessWidget {
  const TrasladosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF5F7FA),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 1, // Dashboard siempre es el índice 0
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
              "Traslados",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              "Movimiento de productos entre bodegas",
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  return _trasladoCard(
                    origen: "Bodega ${i + 1}",
                    destino: "Bodega ${i + 2}",
                    fecha: "2025-01-${10 + i}",
                    cantidad: "${50 + (i * 10)} items",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trasladoCard({
    required String origen,
    required String destino,
    required String fecha,
    required String cantidad,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.compare_arrows, color: Colors.blue, size: 30),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "De: $origen",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text("A: $destino"),
                const SizedBox(height: 4),
                Text(
                  "Fecha: $fecha",
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  "Cantidad: $cantidad",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_end/shared/widgets/base_page.dart';

class TransferDetailPage extends StatelessWidget {
  final String transferCode;

  const TransferDetailPage({super.key, required this.transferCode});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Detalle del traslado", // Esto se refleja en AppHeader
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              transferCode,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),
            const Text(
              "Estado actual del traslado",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),

            const SizedBox(height: 20),

            /// BADGE DE ESTADO
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Pendiente",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Progreso",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            /// TIMELINE
            const _Timeline(),

            const SizedBox(height: 30),

            const Text(
              "Productos incluidos",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            const _ProductList(),
          ],
        ),
      ),
    );
  }
}

/// ---------- TIMELINE ----------
class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    final steps = [
      {"label": "Solicitado", "done": true},
      {"label": "En camino", "done": false},
      {"label": "Recibido", "done": false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.map((step) {
        final done = step["done"] as bool;
        final label = step["label"] as String;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                done ? Icons.check_circle : Icons.radio_button_unchecked,
                color: done ? Colors.green : Colors.grey.shade400,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: done ? Colors.green : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

/// ---------- PRODUCT LIST ----------
class _ProductList extends StatelessWidget {
  const _ProductList();

  @override
  Widget build(BuildContext context) {
    final products = [
      {"name": "Producto A", "qty": 12},
      {"name": "Producto B", "qty": 6},
      {"name": "Producto C", "qty": 20},
    ];

    return Column(
      children: products.map((p) {
        return Column(
          children: [
            ListTile(
              title: Text(
                p["name"].toString(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Text(
                "x${p["qty"]}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
          ],
        );
      }).toList(),
    );
  }
}

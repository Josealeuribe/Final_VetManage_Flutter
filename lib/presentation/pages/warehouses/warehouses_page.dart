import 'package:flutter/material.dart';
import 'package:project_end/shared/widgets/base_page.dart';

class WarehousesPage extends StatelessWidget {
  const WarehousesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final warehouses = [
      {"name": "Bodega Central", "location": "Guayaquil", "code": "BDG-01"},
      {"name": "Bodega Norte", "location": "Quito", "code": "BDG-02"},
      {"name": "Bodega Sucursal", "location": "Cuenca", "code": "BDG-03"},
    ];

    return BasePage(
      title: "Bodegas", // esto se usa en AppHeader
      body: ListView.builder(
        itemCount: warehouses.length,
        itemBuilder: (context, i) {
          final w = warehouses[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.warehouse_rounded,
                  size: 40,
                  color: Colors.blue,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        w["name"]!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        w["location"]!,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        w["code"]!,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 18),
              ],
            ),
          );
        },
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}

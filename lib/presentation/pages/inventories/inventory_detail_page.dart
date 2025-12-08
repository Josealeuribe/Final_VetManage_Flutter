import 'package:flutter/material.dart';
import 'package:project_end/shared/widgets/base_page.dart';

class InventoryDetailPage extends StatelessWidget {
  const InventoryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Detalle Inventario",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Producto seleccionado",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text("Información detallada del producto..."),
        ],
      ),
    );
  }
}

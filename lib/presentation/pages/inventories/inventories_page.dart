import 'package:flutter/material.dart';
import 'package:project_end/presentation/pages/inventories/inventory_detail_page.dart';
import 'package:project_end/shared/widgets/base_page.dart';

class InventoriesPage extends StatelessWidget {
  const InventoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Inventarios",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Inventarios",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text("Estado general de existencias"),

          const SizedBox(height: 20),

          Row(
            children: [
              _box("Productos", "154", Colors.blue),
              const SizedBox(width: 12),
              _box("Bajo Stock", "12", Colors.orange),
            ],
          ),

          const SizedBox(height: 20),
          const Text("Listado de Productos",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),

          Expanded(
            child: ListView(
              children: [
                _product(context, "Manzanas", "En stock", Colors.green),
                _product(context, "Aguacates", "Bajo stock", Colors.orange),
                _product(context, "Lechuga", "Agotado", Colors.red),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _box(String title, String val, Color c) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: c.withOpacity(.12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(val,
                style:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: c)),
            Text(title, style: TextStyle(color: c)),
          ],
        ),
      ),
    );
  }

  Widget _product(BuildContext context, String name, String st, Color c) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          _anim(const InventoryDetailPage()),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(name),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: c.withOpacity(.15),
                borderRadius: BorderRadius.circular(8)),
            child: Text(st, style: TextStyle(color: c)),
          ),
        ),
      ),
    );
  }

  PageRouteBuilder _anim(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, a, __) => FadeTransition(opacity: a, child: page),
    );
  }
}

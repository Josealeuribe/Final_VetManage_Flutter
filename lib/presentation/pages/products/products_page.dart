import 'package:flutter/material.dart';
import 'package:project_end/widgets/custom_appbar.dart';
import 'package:project_end/widgets/custom_bottom_nav.dart';

class ProductosPage extends StatefulWidget {
  const ProductosPage({super.key});

  @override
  State<ProductosPage> createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  int navIndex = 2;

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
            _header(Icons.inventory_2_rounded, "Productos"),
            const SizedBox(height: 20),
            _placeholder("Aquí verás los productos."),
          ],
        ),
      ),
    );
  }

  Widget _header(IconData icon, String title) => Row(
    children: [
      Icon(icon, size: 28, color: Colors.blue),
      const SizedBox(width: 10),
      Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ],
  );

  Widget _placeholder(String text) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: _box(),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, color: Colors.black54),
    ),
  );

  BoxDecoration _box() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
    ],
  );
}

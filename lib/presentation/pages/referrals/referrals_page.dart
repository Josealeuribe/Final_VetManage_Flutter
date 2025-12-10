import 'package:flutter/material.dart';
import 'package:project_end/widgets/custom_appbar.dart';
import 'package:project_end/widgets/custom_bottom_nav.dart';

class RemisionesPage extends StatelessWidget {
  const RemisionesPage({super.key});

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
              Navigator.pushReplacementNamed(context, "/remisiones");
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
            _header(Icons.receipt_long, "Remisiones"),
            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  _listItem(
                    icon: Icons.receipt,
                    title: "Remisión #001",
                    subtitle: "Cliente: Juan Pérez",
                  ),
                  _listItem(
                    icon: Icons.receipt,
                    title: "Remisión #002",
                    subtitle: "Cliente: María López",
                  ),
                  _listItem(
                    icon: Icons.receipt,
                    title: "Remisión #003",
                    subtitle: "Cliente: Carlos Ruiz",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(IconData icon, String title) => Row(
    children: [
      Icon(icon, size: 30, color: Colors.blue),
      const SizedBox(width: 10),
      Text(
        title,
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
    ],
  );

  Widget _listItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) => Container(
    margin: const EdgeInsets.only(bottom: 12),
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
          backgroundColor: Colors.blue.withOpacity(0.15),
          radius: 22,
          child: Icon(icon, color: Colors.blue, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right, color: Colors.grey.shade600),
      ],
    ),
  );
}

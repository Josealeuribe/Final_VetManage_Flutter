import 'package:flutter/material.dart';
import 'package:v_manage/widgets/custom_appbar.dart';
import 'package:v_manage/widgets/custom_bottom_nav.dart';
import 'purchase_details_page.dart'; // Importa la página de detalles de compra

class ComprasPage extends StatefulWidget {
  const ComprasPage({super.key});

  @override
  State<ComprasPage> createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  int navIndex = 0;
  String searchQuery = ""; // Variable para el filtro de búsqueda

  // Ejemplo de datos de compras
  final List<Map<String, dynamic>> compras = [
    {
      "codigo": "A100",
      "proveedor": "Distribuciones A",
      "fecha": "14/1/2024",
      "estado": "Aprobada",
      "items": 2
    },
    {
      "codigo": "A101",
      "proveedor": "Comercial B",
      "fecha": "13/1/2024",
      "estado": "Aprobada",
      "items": 2
    },
    {
      "codigo": "A102",
      "proveedor": "Importaciones C",
      "fecha": "15/1/2024",
      "estado": "Pendiente",
      "items": 3
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filtrar las compras según la búsqueda
    final filteredCompras = compras.where((compra) {
      final query = searchQuery.toLowerCase();
      return compra["codigo"].toLowerCase().contains(query) ||
          compra["proveedor"].toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: navIndex, // Dashboard siempre es el índice 0
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

      backgroundColor: const Color(0xFFF5F7FA),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(Icons.shopping_cart, "Compras"),
            const SizedBox(height: 20),

            // Filtro de búsqueda
            _searchBar(),

            const SizedBox(height: 20),

            // Lista de compras
            Expanded(
              child: ListView.separated(
                itemCount: filteredCompras.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final compra = filteredCompras[i];
                  return _purchaseCard(compra, context); // Navegación a los detalles
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Encabezado de la página
  Widget _header(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(width: 10),
        Text(title,
            style: const TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Barra de búsqueda
  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: "Buscar por número de compra, proveedor o estado...",
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (v) => setState(() => searchQuery = v),
    );
  }

  // Tarjeta de cada compra
  Widget _purchaseCard(Map<String, dynamic> compra, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a la página de detalles de la compra
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PurchaseDetailsPage(compra: compra), // Página de detalles
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _box(),
        child: Row(
          children: [
            // Ícono de la compra
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(50, 33, 149, 243),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.shopping_cart, color: Colors.blue, size: 28),
            ),
            const SizedBox(width: 14),

            // Información de la compra
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(compra["codigo"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Proveedor: ${compra["proveedor"]}", style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 6),
                  Text("Fecha: ${compra["fecha"]}", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),

            // Estado de la compra
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: compra["estado"] == "Aprobada"
                        ? Colors.blue.withOpacity(0.15)
                        : compra["estado"] == "Pendiente"
                            ? Colors.orange.withOpacity(0.15)
                            : Colors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    compra["estado"],
                    style: TextStyle(
                      color: compra["estado"] == "Aprobada"
                          ? Colors.blue
                          : compra["estado"] == "Pendiente"
                              ? Colors.orange
                              : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Decoración de las tarjetas
  BoxDecoration _box() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:v_manage/widgets/custom_appbar.dart';
import 'package:v_manage/widgets/custom_bottom_nav.dart';
import 'remission_details_page.dart'; // Importa la página de detalles de remisión

class RemisionesPage extends StatefulWidget {
  const RemisionesPage({super.key});

  @override
  State<RemisionesPage> createState() => _RemisionesPageState();
}

class _RemisionesPageState extends State<RemisionesPage> {
  int navIndex = 0;
  String searchQuery = ""; // Variable para el filtro de búsqueda

  // Ejemplo de datos de remisiones
  final List<Map<String, dynamic>> remisiones = [
    {
      "codigo": "RC-001",
      "ordenCompra": "OC-001",
      "proveedor": "Alimentos San José S.A.",
      "fecha": "14/1/2024",
      "estado": "Aprobada",
      "items": 1
    },
    {
      "codigo": "RC-002",
      "ordenCompra": "OC-002",
      "proveedor": "Veterinaria La Esperanza",
      "fecha": "13/1/2024",
      "estado": "Aprobada",
      "items": 1
    },
    {
      "codigo": "RC-003",
      "ordenCompra": "OC-003",
      "proveedor": "Distribuidora Agropecuaria",
      "fecha": "15/1/2024",
      "estado": "Pendiente",
      "items": 3
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filtrar las remisiones según la búsqueda
    final filteredRemisiones = remisiones.where((remision) {
      final query = searchQuery.toLowerCase();
      return remision["codigo"].toLowerCase().contains(query) ||
          remision["ordenCompra"].toLowerCase().contains(query) ||
          remision["proveedor"].toLowerCase().contains(query);
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
            _header(Icons.receipt_long, "Remisiones"),
            const SizedBox(height: 20),

            // Barra de búsqueda
            _searchBar(),

            const SizedBox(height: 20),

            // Lista de remisiones
            Expanded(
              child: ListView.separated(
                itemCount: filteredRemisiones.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final remision = filteredRemisiones[i];
                  return _remissionCard(remision, context);
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
        hintText: "Buscar por remisión, orden, proveedor o estado...",
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

  // Tarjeta de cada remisión
  Widget _remissionCard(Map<String, dynamic> remision, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a la página de detalles de la remisión
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RemissionDetailsPage(remision: remision), // Página de detalles
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _box(),
        child: Row(
          children: [
            // Ícono de la remisión
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(50, 33, 149, 243),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.receipt, color: Colors.blue, size: 28),
            ),
            const SizedBox(width: 14),

            // Información de la remisión
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(remision["codigo"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Orden: ${remision["ordenCompra"]}", style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 6),
                  Text("Proveedor: ${remision["proveedor"]}", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),

            // Estado de la remisión
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: remision["estado"] == "Aprobada"
                        ? Colors.blue.withOpacity(0.15)
                        : remision["estado"] == "Pendiente"
                            ? Colors.orange.withOpacity(0.15)
                            : Colors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    remision["estado"],
                    style: TextStyle(
                      color: remision["estado"] == "Aprobada"
                          ? Colors.blue
                          : remision["estado"] == "Pendiente"
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

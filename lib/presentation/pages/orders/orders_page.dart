import 'package:flutter/material.dart';
import 'package:v_manage/widgets/custom_appbar.dart';
import 'package:v_manage/widgets/custom_bottom_nav.dart';

// Importa el archivo que contiene la página de detalles de la orden
import 'order_details_page.dart'; // Asegúrate de tener la ruta correcta del archivo

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int navIndex = 0;
  String searchQuery = ""; // Variable para el filtro de búsqueda

  // Ejemplo de datos de las órdenes
  final List<Map<String, dynamic>> orders = [
    {
      "codigo": "ORD-001",
      "cliente": "Juan Carlos Pérez Rodríguez",
      "fecha": "14/1/2024",
      "vencimiento": "19/1/2024",
      "estado": "Procesando",
      "items": 2
    },
    {
      "codigo": "ORD-002",
      "cliente": "María Fernanda García López",
      "fecha": "13/1/2024",
      "vencimiento": "18/1/2024",
      "estado": "Enviada",
      "items": 1
    },
    {
      "codigo": "ORD-003",
      "cliente": "Distribuidora ABC S.A.S.",
      "fecha": "15/1/2024",
      "vencimiento": "20/1/2024",
      "estado": "Pendiente",
      "items": 2
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filtrar las órdenes según la búsqueda
    final filteredOrders = orders.where((order) {
      final query = searchQuery.toLowerCase();
      return order["codigo"].toLowerCase().contains(query) ||
          order["cliente"].toLowerCase().contains(query);
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
            _header(Icons.list_alt, "Órdenes"),
            const SizedBox(height: 20),

            // Filtro de búsqueda
            _searchBar(),

            const SizedBox(height: 20),

            // Lista de órdenes
            Expanded(
              child: ListView.separated(
                itemCount: filteredOrders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final order = filteredOrders[i];
                  return _orderCard(order);
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
        Icon(icon, size: 28, color: Colors.blue),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Barra de búsqueda
  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: "Buscar por número de orden, cliente o estado...",
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

  // Tarjeta de cada orden
  Widget _orderCard(Map<String, dynamic> order) {
    return GestureDetector(
      onTap: () {
        // Navegar a la página de detalles de la orden
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderDetailsPage(order: order), // Página de detalles
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _box(),
        child: Row(
          children: [
            // Ícono de la orden
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(50, 33, 149, 243),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.shopping_cart, color: Colors.blue, size: 28),
            ),
            const SizedBox(width: 14),

            // Información de la orden
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order["codigo"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Cliente: ${order["cliente"]}", style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 6),
                  Text("Fecha: ${order["fecha"]}", style: TextStyle(color: Colors.grey[600])),
                  Text("Vencimiento: ${order["vencimiento"]}", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),

            // Estado de la orden
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: order["estado"] == "Procesando"
                        ? Colors.blue.withOpacity(0.15)
                        : order["estado"] == "Enviada"
                            ? Colors.purple.withOpacity(0.15)
                            : Colors.orange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order["estado"],
                    style: TextStyle(
                      color: order["estado"] == "Procesando"
                          ? Colors.blue
                          : order["estado"] == "Enviada"
                              ? Colors.purple
                              : Colors.orange,
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

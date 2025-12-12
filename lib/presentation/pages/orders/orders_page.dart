import 'package:flutter/material.dart';
import 'package:project_end/widgets/custom_appbar.dart';
import 'package:project_end/widgets/custom_bottom_nav.dart';
import 'ordenes_detalle_page.dart';

class OrdenesPage extends StatefulWidget {
  const OrdenesPage({super.key});

  @override
  State<OrdenesPage> createState() => _OrdenesPageState();
}

class _OrdenesPageState extends State<OrdenesPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _ordenes = [
    {
      "codigo": "ORD-1001",
      "cliente": "Juan Pérez",
      "fecha": "2025-01-12",
      "total": 250000,
      "estado": "Pendiente",
    },
    {
      "codigo": "ORD-1002",
      "cliente": "Laura Gómez",
      "fecha": "2025-01-10",
      "total": 180000,
      "estado": "Pagada",
    },
    {
      "codigo": "ORD-1003",
      "cliente": "Tienda San Jorge",
      "fecha": "2025-01-09",
      "total": 420000,
      "estado": "Pendiente",
    },
    {
      "codigo": "ORD-1004",
      "cliente": "Distribuciones Mar",
      "fecha": "2025-01-05",
      "total": 750000,
      "estado": "Cancelada",
    },
  ];

  String _query = "";

  // ---------------------------
  // TÍTULO (como el módulo de clientes)
  // ---------------------------
  Widget _title() {
    return Row(
      children: const [
        Icon(Icons.receipt_long, color: Colors.blue, size: 28),
        SizedBox(width: 10),
        Text(
          "Ordenes",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _ordenes.where((o) {
      return o["codigo"].toLowerCase().contains(_query.toLowerCase()) ||
          o["cliente"].toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF5F7FA),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3,
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
              break;
          }
        },
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _title(),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: _box(),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
                decoration: const InputDecoration(
                  hintText: "Buscar orden o cliente...",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final o = filtered[i];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrdenDetallePage(
                          codigo: o["codigo"],
                          cliente: o["cliente"],
                          fecha: o["fecha"],
                          total: o["total"],
                          estado: o["estado"],
                        ),
                      ),
                    );
                  },
                  child: _ordenCard(o),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------
  // CARD DE ORDEN
  // ---------------------------
  Widget _ordenCard(Map<String, dynamic> o) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: _box(),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.blue.shade100,
            child: const Icon(Icons.receipt_long, color: Colors.blue, size: 30),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  o["codigo"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  o["cliente"],
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "Fecha: ${o["fecha"]}",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${o["total"]}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: _estadoColor(o["estado"]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  o["estado"],
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _estadoColor(String estado) {
    switch (estado) {
      case "Pendiente":
        return Colors.orange;
      case "Pagada":
        return Colors.green;
      case "Cancelada":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  BoxDecoration _box() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
    ],
  );
}

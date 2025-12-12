import 'package:flutter/material.dart';
import 'package:v_manage/widgets/custom_appbar.dart';
import 'package:v_manage/widgets/custom_bottom_nav.dart';
import 'bodega_detalle_page.dart';

class BodegasPage extends StatefulWidget {
  const BodegasPage({super.key});

  @override
  State<BodegasPage> createState() => _BodegasPageState();
}

class _BodegasPageState extends State<BodegasPage> {
  String search = "";

  final List<Map<String, dynamic>> bodegas = [
    {
      "id": "BOD-001",
      "nombre": "Bodega Principal",
      "direccion": "Km 5 Vía Norte, Parque Industrial",
      "responsable": "Carlos Pérez",
      "capacidad": "12,000 items",
      "stockTotal": 7430,
      "contacto": "315-555-0101",
      "productos": [
        {"nombre": "Concentrado Inicial Lechones", "stock": 350},
        {"nombre": "Ivermectina 1%", "stock": 600},
        {"nombre": "Oxitetra LA", "stock": 80},
      ]
    },
    {
      "id": "BOD-002",
      "nombre": "Bodega Sur",
      "direccion": "Av. Sur 120",
      "responsable": "María López",
      "capacidad": "8,000 items",
      "stockTotal": 4120,
      "contacto": "315-555-0202",
      "productos": [
        {"nombre": "Concentrado Levante", "stock": 420},
        {"nombre": "Desinfectante VetClean", "stock": 120},
      ]
    },
    {
      "id": "BOD-003",
      "nombre": "Bodega Norte",
      "direccion": "Parque Norte - Calle 8",
      "responsable": "Juan Ruiz",
      "capacidad": "6,000 items",
      "stockTotal": 2890,
      "contacto": "315-555-0303",
      "productos": [
        {"nombre": "Cal Agrícola", "stock": 95},
        {"nombre": "Vitaminas Equinas", "stock": 520},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = bodegas.where((b) {
      final q = search.toLowerCase();
      return b["nombre"].toLowerCase().contains(q) ||
          b["direccion"].toLowerCase().contains(q) ||
          b["responsable"].toLowerCase().contains(q) ||
          b["id"].toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF5F7FA),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3, // dejamos 2 para que el color del nav sea coherente (existencias)
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

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            const SizedBox(height: 14),

            // Buscador
            _searchBox(),

            const SizedBox(height: 16),

            // Resumen rápido
            _summaryRow(filtered.length),

            const SizedBox(height: 12),

            // Lista
            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _bodegaCard(filtered[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Row(
      children: const [
        Icon(Icons.home_work_outlined, size: 28, color: Colors.blue),
        SizedBox(width: 10),
        Text(
          "Bodegas",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Buscar bodega, dirección, responsable...",
          icon: Icon(Icons.search),
        ),
        onChanged: (v) => setState(() => search = v),
      ),
    );
  }

  Widget _summaryRow(int count) {
    return Row(
      children: [
        _chip("Total bodegas: $count"),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Text(text, style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w600)),
    );
  }

  Widget _bodegaCard(Map<String, dynamic> b) {
    return GestureDetector(
      onTap: () {
        // Navegar al detalle pasando la bodega completa
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => BodegaDetallePage(data: b),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(opacity: anim, child: child);
            },
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.blue.withOpacity(0.12),
              child: const Icon(Icons.warehouse, color: Colors.blue, size: 26),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(b["nombre"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(b["direccion"], style: const TextStyle(fontSize: 13, color: Colors.black54)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _smallInfo("Resp.", b["responsable"]),
                      const SizedBox(width: 8),
                      _smallInfo("Stock", "${b["stockTotal"]}"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _smallInfo(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text("$label: ", style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

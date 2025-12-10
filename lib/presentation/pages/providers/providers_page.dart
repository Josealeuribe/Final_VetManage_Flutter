import 'package:flutter/material.dart';
import 'package:project_end/presentation/pages/providers/proveedores_detalle_page.dart';
import 'package:project_end/widgets/custom_appbar.dart';
import 'package:project_end/widgets/custom_bottom_nav.dart';

class ProveedoresPage extends StatefulWidget {
  const ProveedoresPage({super.key});

  @override
  State<ProveedoresPage> createState() => _ProveedoresPageState();
}

class _ProveedoresPageState extends State<ProveedoresPage> {
  String search = "";

  final List<Map<String, dynamic>> proveedores = [
    {
      "nombre": "Distribuidora Central",
      "contacto": "Carlos Pérez",
      "telefono": "300 456 7890",
      "ciudad": "Bogotá",
      "estado": "Activo",
      "productos": 54,
    },
    {
      "nombre": "Alimentos del Norte",
      "contacto": "Ana Gómez",
      "telefono": "312 567 9012",
      "ciudad": "Medellín",
      "estado": "Activo",
      "productos": 32,
    },
    {
      "nombre": "Suministros Express",
      "contacto": "Roberto Jiménez",
      "telefono": "301 999 1122",
      "ciudad": "Cali",
      "estado": "Inactivo",
      "productos": 12,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = proveedores.where((p) {
      final q = search.toLowerCase();
      return p["nombre"].toLowerCase().contains(q) ||
          p["contacto"].toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF5F7FA),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3,
        onTap: (i) {
          switch (i) {
            case 0: Navigator.pushReplacementNamed(context, "/dashboard"); break;
            case 1: Navigator.pushReplacementNamed(context, "/traslados"); break;
            case 2: Navigator.pushReplacementNamed(context, "/existencias"); break;
            case 3: break;
          }
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            const SizedBox(height: 16),

            _searchBox(),
            const SizedBox(height: 16),

            _chip("Total proveedores: ${filtered.length}"),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _proveedorCard(filtered[i]),
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
        Icon(Icons.local_shipping, color: Colors.blue, size: 28),
        SizedBox(width: 10),
        Text(
          "Proveedores",
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
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Buscar proveedor o contacto...",
          icon: Icon(Icons.search),
        ),
        onChanged: (v) => setState(() => search = v),
      ),
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
      child: Text(
        text,
        style: TextStyle(color: Colors.blue.shade700),
      ),
    );
  }

  Widget _proveedorCard(Map<String, dynamic> p) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => DetalleProveedorPage(proveedor: p),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _box(),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.orange.withOpacity(0.15),
              child: const Icon(Icons.store, color: Colors.orange, size: 26),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p["nombre"],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    "Contacto: ${p["contacto"]}",
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  _estadoTag(p["estado"]),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _estadoTag(String estado) {
    final color = estado == "Activo" ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        estado,
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }

  BoxDecoration _box() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      );
}

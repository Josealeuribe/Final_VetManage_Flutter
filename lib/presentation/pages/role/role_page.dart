import 'package:flutter/material.dart';
import 'package:project_end/widgets/custom_appbar.dart';
import 'package:project_end/widgets/custom_bottom_nav.dart';
import 'roles_detalle_page.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  String search = "";

  final List<Map<String, dynamic>> roles = [
    {
      "nombre": "Administrador",
      "descripcion": "Acceso total al sistema",
      "permisos": ["Dashboard", "Inventarios", "Ventas", "Usuarios", "Reportes"],
      "estado": "Activo",
    },
    {
      "nombre": "Operador de Ventas",
      "descripcion": "Gestiona clientes y ventas",
      "permisos": ["Clientes", "Ventas"],
      "estado": "Activo",
    },
    {
      "nombre": "Inventarios",
      "descripcion": "Control de entradas y salidas",
      "permisos": ["Productos", "Stock", "Traslados"],
      "estado": "Inactivo",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = roles.where((r) {
      final q = search.toLowerCase();
      return r["nombre"].toLowerCase().contains(q) ||
          r["descripcion"].toLowerCase().contains(q);
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

            _chip("Total roles: ${filtered.length}"),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _rolCard(filtered[i]),
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
        Icon(Icons.shield, color: Colors.blue, size: 28),
        SizedBox(width: 10),
        Text(
          "Roles del Sistema",
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
          hintText: "Buscar rol o descripción...",
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
      child: Text(text, style: TextStyle(color: Colors.blue.shade700)),
    );
  }

  Widget _rolCard(Map<String, dynamic> r) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => RolesDetallePage(
              nombre: r["nombre"],
              descripcion: r["descripcion"],
              permisos: List<String>.from(r["permisos"]),
              estado: r["estado"],
            ),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
          ),
        );
      },
      child: Container(
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
              radius: 26,
              backgroundColor: Colors.blue.withOpacity(0.12),
              child: const Icon(Icons.shield, color: Colors.blue, size: 26),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r["nombre"],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    r["descripcion"],
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  _estadoTag(r["estado"]),
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
}

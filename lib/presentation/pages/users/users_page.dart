import 'package:flutter/material.dart';
import 'package:v_manage/presentation/pages/users/usuario_detalle_page.dart';
import 'package:v_manage/widgets/custom_appbar.dart';
import 'package:v_manage/widgets/custom_bottom_nav.dart';


class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  String search = "";

  final List<Map<String, dynamic>> usuarios = [
    {
      "nombre": "Jireh Arango",
      "rol": "Admin",
      "correo": "admin@empresa.com",
      "telefono": "310-555-1000",
      "estado": "Activo",
    },
    {
      "nombre": "Jose Uribe",
      "rol": "Ventas",
      "correo": "ventas@empresa.com",
      "telefono": "311-555-2000",
      "estado": "Activo",
    },
    {
      "nombre": "Juan Sierra",
      "rol": "Inventarios",
      "correo": "inventarios@empresa.com",
      "telefono": "312-555-3000",
      "estado": "Inactivo",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = usuarios.where((u) {
      final q = search.toLowerCase();
      return u["nombre"].toLowerCase().contains(q) ||
          u["rol"].toLowerCase().contains(q) ||
          u["correo"].toLowerCase().contains(q);
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

            _chip("Total usuarios: ${filtered.length}"),
            const SizedBox(height: 14),

            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _usuarioCard(filtered[i]),
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
        Icon(Icons.person_3, color: Colors.blue, size: 28),
        SizedBox(width: 10),
        Text(
          "Usuarios",
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
          hintText: "Buscar nombre, rol o correo...",
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

  Widget _usuarioCard(Map<String, dynamic> u) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => UsuariosDetallePage(
              nombre: u["nombre"],
              rol: u["rol"],
              correo: u["correo"],
              telefono: u["telefono"],
              estado: u["estado"],
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
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.blue.withOpacity(0.12),
              child: const Icon(Icons.person, color: Colors.blue, size: 26),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(u["nombre"],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(u["rol"], style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 6),
                  _estadoTag(u["estado"]),
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

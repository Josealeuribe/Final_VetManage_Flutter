import 'package:flutter/material.dart';
import 'package:v_manage/presentation/pages/clients/clientes_detalle_page.dart';
import 'package:v_manage/widgets/custom_appbar.dart';
import 'package:v_manage/widgets/custom_bottom_nav.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  String search = "";

  final List<Map<String, dynamic>> clientes = [
    {
      "id": "CLI-001",
      "nombre": "Agropecuaria San Miguel",
      "contacto": "Juan Pérez",
      "telefono": "311-555-0101",
      "correo": "juan@sanmiguel.com",
      "direccion": "Km 3 Vía Principal, Sector El Molino",
      "ciudad": "Villavicencio",
      "estado": "Activo",
      "compras": 132,
      "saldo": 250000.0,
      "observaciones": "Cliente frecuente, pago puntual.",
    },
    {
      "id": "CLI-002",
      "nombre": "Veterinaria Los Llanos",
      "contacto": "María Gómez",
      "telefono": "312-888-0909",
      "correo": "contacto@llanosvet.com",
      "direccion": "Calle 12 #45-90",
      "ciudad": "Villavicencio",
      "estado": "Activo",
      "compras": 98,
      "saldo": 120000.0,
      "observaciones": "Solicita seguimiento mensual.",
    },
    {
      "id": "CLI-003",
      "nombre": "Granja La Esperanza",
      "contacto": "Carlos Ruiz",
      "telefono": "315-700-2233",
      "correo": "cruiz@esperanza.co",
      "direccion": "Vereda San Pedro, lote 22",
      "ciudad": "Acacías",
      "estado": "Inactivo",
      "compras": 40,
      "saldo": 0.0,
      "observaciones": "Última compra hace 6 meses.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = clientes.where((c) {
      final q = search.toLowerCase();
      return c["nombre"].toLowerCase().contains(q) ||
          c["contacto"].toLowerCase().contains(q) ||
          c["id"].toLowerCase().contains(q);
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

            _chip("Total clientes: ${filtered.length}"),
            const SizedBox(height: 14),

            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _clienteCard(filtered[i]),
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
        Icon(Icons.people_alt_outlined, color: Colors.blue, size: 28),
        SizedBox(width: 10),
        Text(
          "Clientes",
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
          hintText: "Buscar cliente, contacto o ID...",
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

  Widget _clienteCard(Map<String, dynamic> c) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => ClienteDetallePage(
              nombre: c["nombre"],
              codigo: c["id"],
              telefono: c["telefono"],
              direccion: c["direccion"],
              correo: c["correo"],
              ciudad: c["ciudad"],
              estado: c["estado"],
              compras: c["compras"],
              saldo: c["saldo"],
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
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
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
                  Text(c["nombre"], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(c["contacto"], style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _tag("Compras: ${c["compras"]}"),
                      const SizedBox(width: 8),
                      _estadoTag(c["estado"]),
                    ],
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
    );
  }

  Widget _estadoTag(String estado) {
    Color color = estado == "Activo" ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        estado,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}

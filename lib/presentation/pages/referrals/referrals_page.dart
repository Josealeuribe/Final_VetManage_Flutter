import 'package:flutter/material.dart';
import 'package:project_end/presentation/pages/referrals/remisiones_detalle_page.dart';
import 'package:project_end/widgets/custom_appbar.dart';
import 'package:project_end/widgets/custom_bottom_nav.dart';

class RemisionesPage extends StatefulWidget {
  const RemisionesPage({super.key});

  @override
  State<RemisionesPage> createState() => _RemisionesPageState();
}

class _RemisionesPageState extends State<RemisionesPage> {
  final TextEditingController buscarCtrl = TextEditingController();

  List<Map<String, dynamic>> remisiones = [
    {
      "codigo": "001",
      "cliente": "Juan Pérez",
      "fecha": "2025-01-10",
      "estado": "Entregado",
      "total": 150000,
    },
    {
      "codigo": "002",
      "cliente": "María López",
      "fecha": "2025-01-15",
      "estado": "Pendiente",
      "total": 85000,
    },
    {
      "codigo": "003",
      "cliente": "Carlos Ruiz",
      "fecha": "2025-01-18",
      "estado": "Entregado",
      "total": 230000,
    }
  ];

  List<Map<String, dynamic>> remisionesFiltradas = [];

  @override
  void initState() {
    super.initState();
    remisionesFiltradas = List.from(remisiones);
    buscarCtrl.addListener(_filtrar);
  }

  void _filtrar() {
    final txt = buscarCtrl.text.toLowerCase();

    setState(() {
      remisionesFiltradas = remisiones.where((r) {
        return r["codigo"].toLowerCase().contains(txt) ||
            r["cliente"].toLowerCase().contains(txt) ||
            r["fecha"].toLowerCase().contains(txt);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 18),
            _buscador(),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: remisionesFiltradas.length,
                itemBuilder: (context, index) {
                  final r = remisionesFiltradas[index];
                  return _cardRemision(r, context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: const [
        Icon(Icons.receipt_long, color: Colors.blue, size: 30),
        SizedBox(width: 10),
        Text(
          "Remisiones",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _buscador() {
    return TextField(
      controller: buscarCtrl,
      decoration: InputDecoration(
        hintText: "Buscar remisión...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }

  Widget _cardRemision(Map<String, dynamic> r, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RemisionDetallePage(remision: r),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              offset: const Offset(0, 3),
              color: Colors.black.withOpacity(0.07),
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue.withOpacity(0.15),
              child: const Icon(Icons.receipt, color: Colors.blue, size: 22),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Remisión #${r["codigo"]}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Cliente: ${r["cliente"]}",
                    style:
                        const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    r["fecha"],
                    style:
                        const TextStyle(fontSize: 12, color: Colors.black45),
                  )
                ],
              ),
            ),

            Text(
              "\$${r["total"]}",
              style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            const SizedBox(width: 10),

            Icon(Icons.chevron_right, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }
}

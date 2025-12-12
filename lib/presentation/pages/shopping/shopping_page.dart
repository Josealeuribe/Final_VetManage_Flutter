import 'package:flutter/material.dart';
import 'package:project_end/presentation/pages/shopping/comrpa_detalle_page.dart';
import 'package:project_end/widgets/custom_appbar.dart';
import 'package:project_end/widgets/custom_bottom_nav.dart';

class ComprasPage extends StatefulWidget {
  const ComprasPage({super.key});

  @override
  State<ComprasPage> createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  final TextEditingController buscarCtrl = TextEditingController();

  List<Map<String, dynamic>> compras = [
    {
      "codigo": "A100",
      "proveedor": "Distribuciones A",
      "fecha": "2025-01-10",
      "total": 452000,
      "estado": "Completado"
    },
    {
      "codigo": "A101",
      "proveedor": "Comercial B",
      "fecha": "2025-01-14",
      "total": 198000,
      "estado": "Pendiente"
    },
    {
      "codigo": "A102",
      "proveedor": "Importaciones C",
      "fecha": "2025-01-17",
      "total": 732000,
      "estado": "Completado"
    },
    {
      "codigo": "A103",
      "proveedor": "Distribuidora Licores D",
      "fecha": "2025-01-20",
      "total": 910000,
      "estado": "Pendiente"
    },
  ];

  List<Map<String, dynamic>> comprasFiltradas = [];

  @override
  void initState() {
    super.initState();
    comprasFiltradas = List.from(compras);
    buscarCtrl.addListener(_filtrar);
  }

  void _filtrar() {
    String txt = buscarCtrl.text.toLowerCase();
    setState(() {
      comprasFiltradas = compras.where((compra) {
        return compra["codigo"].toLowerCase().contains(txt) ||
            compra["proveedor"].toLowerCase().contains(txt) ||
            compra["fecha"].toLowerCase().contains(txt);
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
                itemCount: comprasFiltradas.length,
                itemBuilder: (context, index) {
                  final compra = comprasFiltradas[index];
                  return _cardCompra(compra, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: const [
        Icon(Icons.shopping_cart, color: Colors.blue, size: 30),
        SizedBox(width: 10),
        Text(
          "Compras",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _buscador() {
    return TextField(
      controller: buscarCtrl,
      decoration: InputDecoration(
        hintText: "Buscar compra...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _cardCompra(Map<String, dynamic> compra, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CompraDetallePage(compra: compra),
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
            _icono(),
            const SizedBox(width: 14),
            _info(compra),
            Text(
              "\$${compra["total"].toString()}",
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 10),
            Icon(Icons.chevron_right, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }

  Widget _icono() {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.blue.withOpacity(0.15),
      child: const Icon(Icons.shopping_bag, color: Colors.blue, size: 22),
    );
  }

  Widget _info(Map<String, dynamic> compra) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Compra #${compra["codigo"]}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 3),
          Text(
            "Proveedor: ${compra["proveedor"]}",
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 3),
          Text(
            compra["fecha"],
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

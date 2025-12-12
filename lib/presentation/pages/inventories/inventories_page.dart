import 'package:flutter/material.dart';
import 'package:v_manage/widgets/custom_appbar.dart';
import 'package:v_manage/widgets/custom_bottom_nav.dart';
import 'existencias_detail_page.dart';

class ExistenciasPage extends StatefulWidget {
  const ExistenciasPage({super.key});

  @override
  State<ExistenciasPage> createState() => _ExistenciasPageState();
}

class _ExistenciasPageState extends State<ExistenciasPage> {
  String search = "";

  final List<Map<String, dynamic>> existencias = [
    {
      "id": "PROD-001",
      "nombre": "Concentrado Inicial Lechones",
      "categoria": "Alimentos",
      "iva": "19%",
      "stock": 850,
      "estado": "Activo",
      "descripcion":
          "Alimento balanceado para lechones de 0-8 semanas – Bulto 40kg",
      "lotes": [
        {
          "lote": "AL–2824–001",
          "cantidad": 350,
          "vence": "14/06/2025",
          "bodega": "Bodega Principal"
        },
        {
          "lote": "AL–2824–045",
          "cantidad": 300,
          "vence": "19/08/2025",
          "bodega": "Bodega Secundaria"
        },
        {
          "lote": "AL–2824–078",
          "cantidad": 200,
          "vence": "09/05/2025",
          "bodega": "Bodega Norte"
        },
      ],
    },
    {
      "id": "PROD-002",
      "nombre": "Concentrado Levante",
      "categoria": "Alimentos",
      "iva": "19%",
      "stock": 920,
      "estado": "Activo",
      "descripcion":
          "Alimento para etapa de levante – Bulto 40kg",
      "lotes": [
        {
          "lote": "AL–2824–012",
          "cantidad": 420,
          "vence": "29/07/2025",
          "bodega": "Bodega Principal"
        },
        {
          "lote": "AL–2824–856",
          "cantidad": 350,
          "vence": "14/09/2025",
          "bodega": "Bodega Secundaria"
        },
        {
          "lote": "AL–2824–889",
          "cantidad": 150,
          "vence": "24/06/2025",
          "bodega": "Bodega Principal"
        },
      ],
    },
    {
      "id": "PROD-003",
      "nombre": "Vitamina ADE Inyectable",
      "categoria": "Vitaminas y Suplementos",
      "iva": "19%",
      "stock": 180,
      "estado": "Activo",
      "descripcion": "Solución inyectable 50ml",
      "lotes": [
        {
          "lote": "VT–9001",
          "cantidad": 60,
          "vence": "12/04/2026",
          "bodega": "Bodega Principal"
        },
        {
          "lote": "VT–9002",
          "cantidad": 120,
          "vence": "10/09/2026",
          "bodega": "Bodega Norte"
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = existencias.where((e) {
      return e["nombre"].toString().toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF5F7FA),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 2,
        onTap: (i) {
          switch (i) {
            case 0:
              Navigator.pushReplacementNamed(context, "/dashboard");
              break;
            case 1:
              Navigator.pushReplacementNamed(context, "/traslados");
              break;
            case 2:
              break;
          }
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header("Existencias"),
            const SizedBox(height: 20),
            _searchBar(),
            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (_, i) => _existenciaCard(filtered[i]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header(String title) {
    return Row(
      children: [
        const Icon(Icons.inventory_2, size: 28, color: Colors.blue),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)
        ],
      ),
      child: TextField(
        onChanged: (v) => setState(() => search = v),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Buscar producto...",
          icon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _existenciaCard(Map<String, dynamic> e) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(e["nombre"],
              style: const TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(e["categoria"],
              style: const TextStyle(color: Colors.black54, fontSize: 14)),
          const SizedBox(height: 10),

          Row(
            children: [
              _chip("Stock: ${e["stock"]}", Colors.blue),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetalleExistenciaPage(data: e),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

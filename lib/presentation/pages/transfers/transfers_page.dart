import 'package:flutter/material.dart';
import 'package:v_manage/widgets/custom_appbar.dart';
import 'package:v_manage/widgets/custom_bottom_nav.dart';
import 'traslado_detalle_page.dart'; // 👈 IMPORTANTE

class TrasladosPage extends StatefulWidget {
  const TrasladosPage({super.key});

  @override
  State<TrasladosPage> createState() => _TrasladosPageState();
}

class _TrasladosPageState extends State<TrasladosPage> {
  int navIndex = 1;
  String searchQuery = "";

  final List<Map<String, dynamic>> traslados = [
    {
      "codigo": "TR-00123",
      "origen": "Bodega Central",
      "destino": "Sucursal Norte",
      "fecha": "2025-01-10",
      "estado": "Enviado",
      "items": 14
    },
    {
      "codigo": "TR-00117",
      "origen": "Bodega Sur",
      "destino": "Tienda A",
      "fecha": "2025-01-08",
      "estado": "Recibido",
      "items": 8
    },
    {
      "codigo": "TR-00110",
      "origen": "Bodega Central",
      "destino": "Sucursal Sur",
      "fecha": "2025-01-05",
      "estado": "En tránsito",
      "items": 22
    },
    {
      "codigo": "TR-00098",
      "origen": "Tienda A",
      "destino": "Bodega Central",
      "fecha": "2025-01-02",
      "estado": "Recibido",
      "items": 5
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = traslados.where((t) {
      final q = searchQuery.toLowerCase();
      return t["codigo"].toLowerCase().contains(q) ||
          t["origen"].toLowerCase().contains(q) ||
          t["destino"].toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF5F7FA),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: navIndex,
        onTap: (i) {
          setState(() => navIndex = i);

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
          }
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Traslados",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              "Movimiento de productos entre bodegas",
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),

            const SizedBox(height: 16),

            // 🔎 Buscador
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Buscar traslado...",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) => setState(() => searchQuery = v),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final t = filtered[i];

                  return _cardTraslado(
                    context,
                    data: t,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardTraslado(
    BuildContext context, {
    required Map<String, dynamic> data,
  }) {
    final codigo = data["codigo"];
    final origen = data["origen"];
    final destino = data["destino"];
    final fecha = data["fecha"];
    final estado = data["estado"];
    final items = data["items"];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TrasladoDetallePage(traslado: data),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(50, 33, 149, 243),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.swap_horiz, color: Colors.blue, size: 28),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(codigo,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("De: $origen → A: $destino",
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 6),
                  Text("Fecha: $fecha", style: TextStyle(color: Colors.grey[600])),
                  Text("Items: $items", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),

            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: estado == "Recibido"
                        ? Colors.green.withOpacity(0.15)
                        : Colors.orange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    estado,
                    style: TextStyle(
                      color: estado == "Recibido" ? Colors.green : Colors.orange,
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
}

import 'package:flutter/material.dart';

class TrasladoDetallePage extends StatelessWidget {
  final Map<String, dynamic> traslado;

  const TrasladoDetallePage({super.key, required this.traslado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detalle de Traslado",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF5F7FA),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Cerrar",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),

            const SizedBox(height: 20),

            _infoGeneral(),

            const SizedBox(height: 20),

            _productos(),

            const SizedBox(height: 20),

            _notas(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Row(
      children: [
        const Icon(Icons.swap_horiz, size: 30, color: Colors.blue),
        const SizedBox(width: 12),
        Text(
          traslado["codigo"],
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _infoGeneral() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rowInfo("Estado", traslado["estado"]),
          _rowInfo("Origen", traslado["origen"]),
          _rowInfo("Destino", traslado["destino"]),
          _rowInfo("Fecha", traslado["fecha"]),
          _rowInfo("Items trasladados", traslado["items"].toString()),
        ],
      ),
    );
  }

  Widget _productos() {
    final List<Map<String, dynamic>> productosMock = [
      {"nombre": "Mouse inalámbrico", "cantidad": 4},
      {"nombre": "Teclado mecánico", "cantidad": 3},
      {"nombre": "Laptop Lenovo 14\"", "cantidad": 2},
      {"nombre": "Monitor LG 24\"", "cantidad": 5},
    ];

    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Productos",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),

          ...productosMock.map(
            (p) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(p["nombre"], style: const TextStyle(fontSize: 15)),
                  Text(
                    "x${p["cantidad"]}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notas() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Notas",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "Traslado realizado como parte de la reorganización "
            "de inventario del mes de enero.",
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _rowInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

class OrdenDetallePage extends StatelessWidget {
  final String codigo;
  final String cliente;
  final String fecha;
  final int total;
  final String estado;

  const OrdenDetallePage({
    super.key,
    required this.codigo,
    required this.cliente,
    required this.fecha,
    required this.total,
    required this.estado,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detalle de Orden",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

            bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Cerrar", style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _header(),

            const SizedBox(height: 20),

            _section(
              title: "Información de la Orden",
              content: Column(
                children: [
                  _item("Código", codigo),
                  _item("Cliente", cliente),
                  _item("Fecha", fecha),
                  _item("Estado", estado),
                  _item("Total", "\$$total"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _section(
              title: "Productos",
              content: Column(
                children: [
                  _product("Arroz 50kg", 2, 120000),
                  _product("Aceite 20L", 1, 60000),
                  _product("Azúcar 25kg", 3, 90000),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HEADER ------------------------------
  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: _box(),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue.shade100,
            child: Icon(Icons.receipt, color: Colors.blue.shade800, size: 34),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  codigo,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cliente,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // SECTION ------------------------------
  Widget _section({required String title, required Widget content}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          content,
        ],
      ),
    );
  }

  // INFO ITEM ------------------------------
  Widget _item(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // PRODUCTO LISTADO ----------------------
  Widget _product(String nombre, int cantidad, int subtotal) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              nombre,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text("x$cantidad"),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "\$$subtotal",
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // BOX DECORATION -------------------------
  BoxDecoration _box() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      );
}

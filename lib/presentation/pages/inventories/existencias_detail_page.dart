import 'package:flutter/material.dart';

class DetalleExistenciaPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetalleExistenciaPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final lotes = data["lotes"] as List;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del producto"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      backgroundColor: const Color(0xFFF5F7FA),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Detalles del Producto"),
            const SizedBox(height: 10),
            const Text(
              "Información completa del producto y sus existencias",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            _infoRow("ID", data["id"]),
            _infoRow("Estado", data["estado"], chipColor: Colors.green),
            _infoRow("Nombre", data["nombre"]),
            _infoRow("Categoría", data["categoria"]),
            _infoRow("Descripción", data["descripcion"]),
            _infoRow("IVA", data["iva"]),
            _infoRow("Stock Total", "${data["stock"]} unidades",
                boldValue: true),

            const SizedBox(height: 25),
            _title("Lotes Disponibles (${lotes.length} totales)"),
            const SizedBox(height: 12),

            ...lotes.map((l) => _loteCard(l)),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Cerrar",
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _title(String text) => Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );

  Widget _infoRow(String label, String value,
      {Color? chipColor, bool boldValue = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 110,
              child: Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15))),
          Expanded(
            child: chipColor == null
                ? Text(
                    value,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: boldValue ? FontWeight.bold : FontWeight.normal,
                    ),
                  )
                : Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: chipColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                          color: chipColor, fontWeight: FontWeight.w600),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _loteCard(Map<String, dynamic> lote) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
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
          _row("N° Lote", lote["lote"]),
          _row("Cantidad", "${lote["cantidad"]} unidades"),
          _row("Vencimiento", lote["vence"],
              highlight: _isNearExpiration(lote["vence"])),
          _row("Bodega", lote["bodega"]),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: highlight ? Colors.red : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isNearExpiration(String fecha) {
    // Si la fecha contiene días en rojo (según diseño web)
    return fecha.contains("/");
  }
}

import 'package:flutter/material.dart';

class BodegaDetallePage extends StatelessWidget {
  final Map<String, dynamic> data;

  const BodegaDetallePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final productos = (data["productos"] as List<dynamic>).cast<Map<String, dynamic>>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(data["nombre"], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Cerrar", style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoCard("ID", data["id"]),
            const SizedBox(height: 12),
            _infoCard("Dirección", data["direccion"]),
            const SizedBox(height: 12),
            _twoColumnCard("Responsable", data["responsable"], "Contacto", data["contacto"]),
            const SizedBox(height: 12),
            _infoCard("Capacidad", data["capacidad"]),
            const SizedBox(height: 12),
            _infoCard("Stock Total", "${data["stockTotal"]} unidades"),

            const SizedBox(height: 18),

            const Text("Productos en esta Bodega", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Lista de productos simples
            ...productos.map((p) => _productRow(p)).toList(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _twoColumnCard(String labelA, String valueA, String labelB, String valueB) {
    return Container(
      padding: const EdgeInsets.all(14),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Row(
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(labelA, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
            const SizedBox(height: 6),
            Text(valueA, style: const TextStyle(fontWeight: FontWeight.w700)),
          ])),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(labelB, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
            const SizedBox(height: 6),
            Text(valueB, style: const TextStyle(fontWeight: FontWeight.w700)),
          ])),
        ],
      ),
    );
  }

  Widget _productRow(Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue.withOpacity(0.12),
            child: const Icon(Icons.inventory_2, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p["nombre"], style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text("Stock: ${p["stock"]}", style: TextStyle(color: Colors.grey.shade600)),
            ]),
          ),
          Text("${p["stock"]}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        ],
      ),
    );
  }
}

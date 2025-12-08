import 'package:flutter/material.dart';
import 'package:project_end/shared/widgets/base_page.dart';
import 'transfer_detail_page.dart';

class TransfersPage extends StatelessWidget {
  const TransfersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Traslados",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Panel de traslados",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            "Consulta y gestiona los movimientos entre bodegas",
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 25),

          /// --- ESTADO RESUMEN ---
          Row(
            children: [
              _summaryBox("Completados", "12", Colors.green),
              const SizedBox(width: 12),
              _summaryBox("Pendientes", "5", Colors.blue),
            ],
          ),

          const SizedBox(height: 30),
          const Text(
            "Lista de traslados",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),

          Expanded(
            child: ListView(
              children: [
                transferTile(context, "TRD-001", "Recibido", Colors.green),
                transferTile(context, "TRD-002", "Pendiente", Colors.blue),
                transferTile(context, "TRD-003", "Pendiente", Colors.blue),
                transferTile(context, "TRD-004", "Pendiente", Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ---------- WIDGET: BOX RESUMEN ----------
  Widget _summaryBox(String label, String count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.10),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 15, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  /// ---------- WIDGET: TILE DE TRASLADO ----------
  Widget transferTile(BuildContext context, String code, String status, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Text(code, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text("Estado: $status", style: const TextStyle(color: Colors.black54)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(status, style: TextStyle(color: color, fontSize: 13)),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TransferDetailPage(transferCode: code)),
          );
        },
      ),
    );
  }
}

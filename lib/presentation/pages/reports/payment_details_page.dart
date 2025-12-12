import 'package:flutter/material.dart';

class PaymentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> transaccion;

  const PaymentDetailsPage({Key? key, required this.transaccion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detalles de la Transacción",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
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
            _notas(),
          ],
        ),
      ),
    );
  }

  // Título de la transacción
  Widget _title() {
    return Row(
      children: [
        const Icon(Icons.receipt, size: 30, color: Colors.blue),
        const SizedBox(width: 12),
        Text(
          transaccion["remision"],
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Información general de la transacción
  Widget _infoGeneral() {
    return _card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rowInfo("Cliente", transaccion["cliente"]),
          _rowInfo("Fecha", transaccion["fecha"]),
          _rowInfo("Método de Pago", transaccion["metodo"]),
          _rowInfo("Monto Total", transaccion["montoTotal"]),
          _rowInfo("Saldo Pendiente", transaccion["saldoPendiente"]),
          _rowInfo("Estado", transaccion["estado"]),
        ],
      ),
    );
  }

  // Información de las notas
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
            "Esta transacción corresponde al pago completo de la orden, "
            "realizado por transferencia bancaria.",
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  // Fila con label y valor
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

  // Contenedor de la tarjeta
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

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class RemisionConductorDetallePage extends StatefulWidget {
  final Map<String, dynamic> remision;

  const RemisionConductorDetallePage({super.key, required this.remision});

  @override
  State<RemisionConductorDetallePage> createState() =>
      _RemisionConductorDetallePageState();
}

class _RemisionConductorDetallePageState
    extends State<RemisionConductorDetallePage> {
  final SignatureController firmaCtrl = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
  );

  bool entregando = false;
  bool entregado = false;

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
          "Detalle de Remisión",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoCard(),
            const SizedBox(height: 20),
            _signatureSection(),
            const SizedBox(height: 30),
            _btnEntregar(),
          ],
        ),
      ),
    );
  }

  Widget _infoCard() {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Remisión #${widget.remision["codigo"]}",
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text("Cliente: ${widget.remision["cliente"]}",
              style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 4),
          Text("Fecha: ${widget.remision["fecha"]}",
              style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 4),
          Text("Dirección: ${widget.remision["direccion"]}",
              style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 6),
          Text("Total: \$${widget.remision["total"]}",
              style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ],
      ),
    );
  }

  Widget _signatureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Firma del cliente",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.07),
              )
            ],
          ),
          child: Signature(
            controller: firmaCtrl,
            backgroundColor: Colors.white,
          ),
        ),

        const SizedBox(height: 10),
        Row(
          children: [
            TextButton(
              onPressed: () => firmaCtrl.clear(),
              child: const Text("Limpiar firma"),
            ),
          ],
        )
      ],
    );
  }

  Widget _btnEntregar() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onPressed: entregado || entregando
          ? null
          : () async {
              if (firmaCtrl.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Debe registrar la firma del cliente"),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              setState(() => entregando = true);
              await Future.delayed(const Duration(seconds: 2));

              setState(() {
                entregando = false;
                entregado = true;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Pedido marcado como entregado"),
                  backgroundColor: Colors.green,
                ),
              );
            },
      child: entregando
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              entregado ? "ENTREGADO" : "Marcar como entregado",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}

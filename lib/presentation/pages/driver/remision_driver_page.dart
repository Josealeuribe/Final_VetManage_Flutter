import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'driver_dashboard.dart';

class RemisionesConductorPage extends StatefulWidget {
  final String codigo;

  const RemisionesConductorPage({super.key, required this.codigo});

  @override
  State<RemisionesConductorPage> createState() =>
      _RemisionesConductorPageState();
}

class _RemisionesConductorPageState extends State<RemisionesConductorPage> {
  bool entregado = false;

  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E66FF),
        elevation: 0,
        title: Text("Remisión ${widget.codigo}"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Detalles de la entrega",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.06),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Cliente: Juan Pérez"),
                  SizedBox(height: 8),
                  Text("Dirección: Cra 20 #14-50"),
                  SizedBox(height: 8),
                  Text("Producto: 10 cajas de alimento"),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              "Firma del cliente",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.06),
                  )
                ],
              ),
              child: Signature(
                controller: signatureController,
                backgroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 12),
            TextButton(
              onPressed: () => signatureController.clear(),
              child: const Text("Borrar firma"),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: entregado
                    ? null
                    : () async {
                        if (signatureController.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("La firma es obligatoria para continuar."),
                            ),
                          );
                          return;
                        }

                        setState(() => entregado = true);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Entrega confirmada correctamente."),
                          ),
                        );

                        await Future.delayed(const Duration(seconds: 1));

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DriverDashboard(
                              remisionEntregada: widget.codigo,
                            ),
                          ),
                          (route) => false,
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E66FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Confirmar entrega",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

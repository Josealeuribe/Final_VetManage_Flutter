import 'package:flutter/material.dart';
import 'package:project_end/widgets/custom_appbar_driver.dart';
import 'remision_driver_page.dart';

class DriverDashboard extends StatelessWidget {
  final String? remisionEntregada;

  const DriverDashboard({super.key, this.remisionEntregada});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      // ✅ SE RESTITUYE TU CUSTOM APPBAR
      appBar: const CustomAppBarDriver(),


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // -----------------------------------
          // TÍTULO PRINCIPAL
          // -----------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                Icon(Icons.receipt_long, color: Colors.blue, size: 28),
                SizedBox(width: 10),
                Text(
                  "Remisiones",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // -----------------------------------
          // SUBTÍTULO
          // -----------------------------------
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Entregas asignadas",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // -----------------------------------
          // LISTA DE REMISIONES
          // -----------------------------------
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _itemEntrega(
                  codigo: "RM-001",
                  cliente: "Juan Pérez",
                  direccion: "Cra 20 #14-50",
                  entregado: remisionEntregada == "RM-001",
                  context: context,
                ),
                _itemEntrega(
                  codigo: "RM-002",
                  cliente: "María López",
                  direccion: "Calle 45 #12-88",
                  entregado: remisionEntregada == "RM-002",
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------
  // CARD DE ENTREGA (SIN CAMBIOS A TU LÓGICA)
  // ---------------------------------------------------
  Widget _itemEntrega({
    required String codigo,
    required String cliente,
    required String direccion,
    required bool entregado,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RemisionesConductorPage(codigo: codigo),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.only(bottom: 14),
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
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue.withOpacity(0.15),
              child: const Icon(Icons.local_shipping, color: Colors.blue),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Remisión $codigo",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Cliente: $cliente",
                      style: const TextStyle(color: Colors.black54)),
                  Text("Dirección: $direccion",
                      style: const TextStyle(
                          color: Colors.black45, fontSize: 12)),
                  const SizedBox(height: 6),

                  if (entregado)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Entregado",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),

            Icon(Icons.chevron_right, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}

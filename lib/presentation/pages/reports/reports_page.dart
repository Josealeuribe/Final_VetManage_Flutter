import 'package:flutter/material.dart';
import 'package:v_manage/widgets/custom_appbar.dart';
import 'package:v_manage/widgets/custom_bottom_nav.dart';
import 'payment_details_page.dart'; // Importa la página de detalles

class ReportesPage extends StatelessWidget {
  const ReportesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF5F7FA),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3, // Dashboard siempre es el índice 0
        onTap: (i) {
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

            case 3:
              // "Más" se abre solo desde el CustomBottomNav
              break;
          }
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la página
            const Text(
              "Pagos y Abonos",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Barra de búsqueda
            _searchBar(),

            const SizedBox(height: 20),

            // Tabla de transacciones
            _table(context), // Se pasa el contexto aquí
          ],
        ),
      ),
    );
  }

  // Barra de búsqueda
  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: "Buscar por transacción, remisión, cliente o estado...",
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Tabla de pagos y abonos
  Widget _table(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 5, // Cambia esto según el número de transacciones
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          return _transactionCard(
            context,
            remision: "RV-00${i + 1}",
            cliente: "Cliente ${i + 1}",
            fecha: "14/1/2024",
            metodo: "Transferencia",
            montoTotal: "\$16,950",
            saldoPendiente: i % 2 == 0 ? "-" : "\$4,605",
            estado: i % 2 == 0 ? "Pagado" : "Pendiente",
          );
        },
      ),
    );
  }

  // Tarjeta de transacción
  Widget _transactionCard(
    BuildContext context, {
    required String remision,
    required String cliente,
    required String fecha,
    required String metodo,
    required String montoTotal,
    required String saldoPendiente,
    required String estado,
  }) {
    return GestureDetector(
      onTap: () {
        // Navegar a la página de detalles de la transacción
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PaymentDetailsPage(
              transaccion: {
                "remision": remision,
                "cliente": cliente,
                "fecha": fecha,
                "metodo": metodo,
                "montoTotal": montoTotal,
                "saldoPendiente": saldoPendiente,
                "estado": estado,
              }, // Pasamos los detalles a la página
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _box(),
        child: Row(
          children: [
            // Ícono de la transacción
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(50, 33, 149, 243),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.receipt, color: Colors.blue, size: 28),
            ),
            const SizedBox(width: 14),

            // Información de la transacción
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(remision, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Cliente: $cliente", style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 6),
                  Text("Fecha: $fecha", style: TextStyle(color: Colors.grey[600])),
                  Text("Método: $metodo", style: TextStyle(color: Colors.grey[600])),
                  Text("Monto Total: $montoTotal", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),

            // Estado de la transacción
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: estado == "Pagado"
                        ? Colors.green.withOpacity(0.15)
                        : estado == "Parcial"
                            ? Colors.orange.withOpacity(0.15)
                            : Colors.red.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    estado,
                    style: TextStyle(
                      color: estado == "Pagado"
                          ? Colors.green
                          : estado == "Parcial"
                              ? Colors.orange
                              : Colors.red,
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

  // Decoración de las tarjetas
  BoxDecoration _box() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
    ],
  );
}

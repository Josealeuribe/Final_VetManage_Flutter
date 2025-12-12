import 'package:flutter/material.dart';
import 'package:project_end/presentation/pages/reports/pago_detalle_page.dart';
import 'package:project_end/widgets/custom_appbar.dart';
import 'package:project_end/widgets/custom_bottom_nav.dart';

class PagosPage extends StatefulWidget {
  const PagosPage({super.key});

  @override
  State<PagosPage> createState() => _PagosPageState();
}

class _PagosPageState extends State<PagosPage> {
  List<Map<String, dynamic>> pagos = [
    {
      "id": "PG-001",
      "cliente": "Juan Pérez",
      "fecha": "2025-02-05",
      "monto": 350.00,
      "estado": "Completado"
    },
    {
      "id": "PG-002",
      "cliente": "María Gómez",
      "fecha": "2025-02-06",
      "monto": 200.00,
      "estado": "Pendiente"
    },
    {
      "id": "PG-003",
      "cliente": "Carlos López",
      "fecha": "2025-02-06",
      "monto": 120.00,
      "estado": "Completado"
    },
  ];

  List<Map<String, dynamic>> pagosFiltrados = [];
  final TextEditingController _buscarCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    pagosFiltrados = List.from(pagos);
    _buscarCtrl.addListener(_filtrar);
  }

  void _filtrar() {
    String txt = _buscarCtrl.text.toLowerCase();

    setState(() {
      pagosFiltrados = pagos.where((pago) {
        return pago["id"].toLowerCase().contains(txt) ||
            pago["cliente"].toLowerCase().contains(txt) ||
            pago["fecha"].toLowerCase().contains(txt);
      }).toList();
    });
  }

  // ----------------------------------------------------
  // TÍTULO DEL MÓDULO
  // ----------------------------------------------------
  Widget _title() {
    return Row(
      children: const [
        Icon(Icons.payments, color: Colors.blue, size: 28),
        SizedBox(width: 10),
        Text(
          "Pagos y Abonos",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFF5F7FA),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3,
        onTap: (i) {
          switch (i) {
            case 0: Navigator.pushReplacementNamed(context, "/dashboard"); break;
            case 1: Navigator.pushReplacementNamed(context, "/traslados"); break;
            case 2: Navigator.pushReplacementNamed(context, "/existencias"); break;
            case 3: break;
          }
        },
      ),
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _title(),
          ),
          const SizedBox(height: 16),

          // BUSCADOR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _buscarCtrl,
              decoration: InputDecoration(
                hintText: "Buscar pago...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // LISTA
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: pagosFiltrados.length,
              itemBuilder: (context, index) {
                final pago = pagosFiltrados[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PagoDetallePage(pago: pago),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.08),
                        )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ICONO
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 44, 97, 255)
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.payments,
                            color: Color.fromARGB(255, 44, 97, 255),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // INFO
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pago["cliente"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                pago["id"],
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Fecha: ${pago["fecha"]}",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // MONTO
                        Text(
                          "\$${pago["monto"].toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 44, 97, 255),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_end/shared/widgets/base_page.dart';

class ProvidersPage extends StatelessWidget {
  const ProvidersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [
      {"name": "Distribuidora García", "ruc": "0992371823", "phone": "096372921"},
      {"name": "Comercial Díaz", "ruc": "0987371232", "phone": "099182736"},
      {"name": "SúperProveedores", "ruc": "0927361283", "phone": "098726361"},
    ];

    return BasePage(
      title: "Proveedores",
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: providers.length,
        itemBuilder: (context, i) {
          final p = providers[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p["name"]!,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text("RUC: ${p["ruc"]}", style: const TextStyle(color: Colors.black54)),
                      const SizedBox(height: 4),
                      Text("Tel: ${p["phone"]}", style: const TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 18),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_end/shared/widgets/base_page.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Clientes",
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ListTile(title: Text("Cliente 1"), subtitle: Text("cliente1@correo.com")),
          ListTile(title: Text("Cliente 2"), subtitle: Text("cliente2@correo.com")),
        ],
      ),
    );
  }
}

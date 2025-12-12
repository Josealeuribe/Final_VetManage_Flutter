import 'package:flutter/material.dart';
import '../../../config/routes.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  void _openMoreMenu(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {"icon": Icons.receipt, "label": "Órdenes", "route": AppRoutes.ordenes},
      {
        "icon": Icons.attach_money,
        "label": "Pagos y Abonos",
        "route": AppRoutes.pagosAbonos,
      },
      {
        "icon": Icons.inventory_2,
        "label": "Existencias",
        "route": AppRoutes.existencias,
      },
      {"icon": Icons.people, "label": "Clientes", "route": AppRoutes.clientes},
      {
        "icon": Icons.store,
        "label": "Proveedores",
        "route": AppRoutes.proveedores,
      },
      {
        "icon": Icons.swap_horiz,
        "label": "Traslados",
        "route": AppRoutes.traslados,
      },
      {
        "icon": Icons.supervisor_account,
        "label": "Usuarios",
        "route": AppRoutes.usuarios,
      },
      {"icon": Icons.security, "label": "Roles", "route": AppRoutes.roles},
      {
        "icon": Icons.assignment,
        "label": "Remisiones",
        "route": AppRoutes.remisiones,
      },
      {
        "icon": Icons.shopping_cart,
        "label": "Compras",
        "route": AppRoutes.compras,
      },
      {"icon": Icons.warehouse, "label": "Bodegas", "route": AppRoutes.bodegas},
      {
        "icon": Icons.dashboard,
        "label": "Dashboard",
        "route": AppRoutes.dashboard,
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 22,
              crossAxisSpacing: 22,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, items[index]["route"]);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color.fromARGB(
                        255,
                        44,
                        97,
                        255,
                      ), // Fondo azul
                      child: Icon(
                        items[index]["icon"],
                        size: 28,
                        color: const Color.fromARGB(
                          255,
                          255,
                          255,
                          255,
                        ), // Íconos blancos
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      items[index]["label"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(
        255,
        44,
        97,
        255,
      ), // Cambié el fondo del contenedor a blanco, puedes poner el color que desees
      currentIndex: currentIndex,
      onTap: (i) {
        if (i == 3) {
          _openMoreMenu(context);
        } else {
          onTap(i);
        }
      },

      selectedItemColor: const Color.fromARGB(
        255,
        44,
        97,
        255,
      ), // Íconos seleccionados en negro
      unselectedItemColor: const Color.fromARGB(
        255,
        44,
        97,
        255,
      ), // Íconos no seleccionados en negro

      items: [
        BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundColor: const Color.fromARGB(
              255,
              44,
              97,
              255,
            ), // Fondo negro para los íconos
            child: Icon(
              Icons.dashboard_outlined,
              color: Colors.white,
              size: 28,
            ), // Ícono blanco
          ),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundColor: const Color.fromARGB(
              255,
              44,
              97,
              255,
            ), // Fondo negro
            child: Icon(
              Icons.swap_horiz,
              color: Colors.white,
              size: 28,
            ), // Ícono blanco
          ),
          label: "Traslados",
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundColor: const Color.fromARGB(
              255,
              44,
              97,
              255,
            ), // Fondo negro
            child: Icon(
              Icons.inventory,
              color: Colors.white,
              size: 28,
            ), // Ícono blanco
          ),
          label: "Existencias",
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundColor: const Color.fromARGB(
              255,
              44,
              97,
              255,
            ), // Fondo negro
            child: Icon(
              Icons.menu,
              color: Colors.white,
              size: 28,
            ), // Ícono blanco
          ),
          label: "Más",
        ),
      ],
    );
  }
}

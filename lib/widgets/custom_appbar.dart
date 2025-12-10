import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,

      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/VSinFondo.png",
            height: 28,
          ),
          const SizedBox(width: 8),
          const Text(
            "Manage",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),

      actions: [
        IconButton(
          icon: const Icon(Icons.sync, color: Colors.blue),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.blue),
          onPressed: () {},
        ),

        /// ===== MENÚ DE USUARIO =====
        PopupMenuButton<String>(
          icon: const Icon(Icons.person, color: Colors.blue),
          onSelected: (value) {
            switch (value) {
              case "profile":
                Navigator.pushNamed(context, "/perfil");
                break;

              case "password":
                Navigator.pushNamed(context, "/cambiar-password");
                break;

              case "settings":
                Navigator.pushNamed(context, "/configuracion");
                break;

              case "help":
                Navigator.pushNamed(context, "/ayuda");
                break;

              case "logout":
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (route) => false);
                break;
            }
          },

          itemBuilder: (context) => [
            const PopupMenuItem(
                value: "profile", child: Text("Editar Perfil")),
            const PopupMenuItem(
                value: "password", child: Text("Cambiar Contraseña")),
            const PopupMenuItem(
                value: "settings", child: Text("Configuración")),
            const PopupMenuItem(
                value: "help", child: Text("Ayuda")),

            const PopupMenuDivider(),

            const PopupMenuItem(
              value: "logout",
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    "Cerrar Sesión",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

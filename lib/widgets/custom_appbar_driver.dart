import 'package:flutter/material.dart';

class CustomAppBarDriver extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 44, 97, 255),
      automaticallyImplyLeading: false,
      centerTitle: true,

      // LOGO + TEXTO (tu diseño original)
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
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),

      // SOLO ICONO QUE CIERRA SESIÓN
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/login",
              (route) => false,
            );
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

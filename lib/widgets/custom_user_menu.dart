import 'package:flutter/material.dart';

class CustomUserMenu extends StatelessWidget {
  final VoidCallback onPerfil;
  final VoidCallback onPassword;
  final VoidCallback onLogout;

  const CustomUserMenu({
    super.key,
    required this.onPerfil,
    required this.onPassword,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.person, color: Colors.white),
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      onSelected: (value) {
        switch (value) {
          case "perfil":
            onPerfil();
            break;

          case "password":
            _showPasswordResetModal(context);
            break;

          case "logout":
            onLogout();
            break;
        }
      },

      itemBuilder: (context) => [
        const PopupMenuItem(
          value: "perfil",
          child: Row(
            children: [
              Icon(Icons.edit, size: 20, color: Colors.blue),
              SizedBox(width: 10),
              Text("Editar Perfil"),
            ],
          ),
        ),

        const PopupMenuItem(
          value: "password",
          child: Row(
            children: [
              Icon(Icons.lock_reset, size: 20, color: Colors.orange),
              SizedBox(width: 10),
              Text("Cambiar Contraseña"),
            ],
          ),
        ),

        const PopupMenuDivider(),

        const PopupMenuItem(
          value: "logout",
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 10),
              Text(
                "Cerrar Sesión",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===============================
  //   MODAL "CORREO ENVIADO"
  // ===============================

  void _showPasswordResetModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.mark_email_read,
                    size: 70, color: Colors.blue),

                const SizedBox(height: 18),

                const Text(
                  "Correo Enviado",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Te enviamos un enlace a tu correo para restablecer tu contraseña.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),

                const SizedBox(height: 22),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 44, 97, 255),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Entendido",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

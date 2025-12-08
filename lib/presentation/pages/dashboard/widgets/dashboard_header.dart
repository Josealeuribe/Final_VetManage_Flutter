import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1E66FF),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {},
      ),
      title: Row(
        children: [
          Image.asset('assets/VSinFonfo.png', height: 32),
          const SizedBox(width: 6),
          const Text(
            "Manage",
            style: TextStyle(fontSize: 20, color: Colors.white),
          )
        ],
      ),
      actions: const [
        Icon(Icons.shopping_cart_outlined, color: Colors.white),
        SizedBox(width: 16),
        Icon(Icons.notifications_none, color: Colors.white),
        SizedBox(width: 16),
      ],
    );
  }
}

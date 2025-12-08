import 'package:flutter/material.dart';

class DashboardBottomNav extends StatefulWidget {
  const DashboardBottomNav({super.key});

  @override
  State<DashboardBottomNav> createState() => _DashboardBottomNavState();
}

class _DashboardBottomNavState extends State<DashboardBottomNav> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF1E66FF),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      onTap: (i) => setState(() => index = i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.inventory), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
      ],
    );
  }
}

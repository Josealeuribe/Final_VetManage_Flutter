// lib/shared/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import '../../presentation/main_navigation.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF1E66FF)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Menú", style: TextStyle(color: Colors.white, fontSize: 22)),
                SizedBox(height: 8),
                Text("Navega por todas las páginas", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),

          ...MainNavigation.menuPages.entries.map((item) => ListTile(
                title: Text(item.key),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => item.value),
                  );
                },
              )),
        ],
      ),
    );
  }
}

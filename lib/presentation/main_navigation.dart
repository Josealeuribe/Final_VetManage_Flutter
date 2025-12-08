import 'package:flutter/material.dart';
import 'pages/dashboard/dashboard_page.dart';
import 'pages/warehouses/warehouses_page.dart';
import 'pages/providers/providers_page.dart';
import 'pages/transfers/transfers_page.dart';
import 'pages/clients/clients_page.dart';
import 'pages/inventories/inventories_page.dart';
import 'pages/reports/reports_page.dart';
import 'pages/products/products_page.dart';
import '../shared/widgets/app_drawer.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  /// Todas las páginas accesibles desde el Drawer
  static final Map<String, Widget> menuPages = {
    "Dashboard": const DashboardPage(),
    "Bodegas": const WarehousesPage(),
    "Proveedores": const ProvidersPage(),
    "Traslados": const TransfersPage(),
    "Clientes": const ClientsPage(),
    "Inventarios": const InventoriesPage(),
    "Reportes": const ReportsPage(),
    "Productos": const ProductsPage(),
  };

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  /// Páginas para el BottomNavigationBar (orden según los ítems)
  final List<Widget> bottomPages = const [
    TransfersPage(),  // Traslados
    ProductsPage(),   // Productos
    ReportsPage(),    // Reportes
    WarehousesPage(), // Bodegas
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(), // Drawer en todas las páginas

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: bottomPages[_currentIndex],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF1E66FF),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz_outlined),
            label: "Traslados",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits_outlined),
            label: "Productos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: "Reportes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warehouse_outlined),
            label: "Bodegas",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

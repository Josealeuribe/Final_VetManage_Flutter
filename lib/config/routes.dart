import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Páginas de módulos
import 'package:v_manage/presentation/pages/reports/reports_page.dart';
import 'package:v_manage/presentation/pages/inventories/inventories_page.dart';
import 'package:v_manage/presentation/pages/orders/orders_page.dart';
import 'package:v_manage/presentation/pages/products/products_page.dart';
import 'package:v_manage/presentation/pages/providers/providers_page.dart';
import 'package:v_manage/presentation/pages/referrals/referrals_page.dart';
import 'package:v_manage/presentation/pages/clients/clients_page.dart';
import 'package:v_manage/presentation/pages/role/role_page.dart';
import 'package:v_manage/presentation/pages/shopping/shopping_page.dart';
import 'package:v_manage/presentation/pages/transfers/transfers_page.dart';
import 'package:v_manage/presentation/pages/users/users_page.dart';
import 'package:v_manage/presentation/pages/warehouses/warehouses_page.dart';

// Auth
import '../presentation/pages/login/login_page.dart';
import '../presentation/pages/dashboard/dashboard_page.dart';
import '../presentation/pages/recover_password/recover_password_page.dart';

// Blocs
import '../presentation/blocs/login/login_bloc.dart';
import '../presentation/blocs/recover/recover_bloc.dart';

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String recover = '/recover';

  // Módulos
  static const String ordenes = '/ordenes';
  static const String proveedores = '/proveedores';
  static const String productos = '/productos';
  static const String existencias = '/existencias';
  static const String clientes = '/clientes';
  static const String usuarios = '/usuarios';
  static const String roles = '/roles';
  static const String remisiones = '/remisiones';
  static const String compras = '/compras';
  static const String bodegas = '/bodegas';
  static const String traslados = '/traslados';
  static const String pagosAbonos = '/pagos_abonos';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LoginBloc(),
            child: const LoginPage(),
          ),
        );

      case dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardPage(),
        );

      case recover:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => RecoverBloc(),
            child: const RecoverPasswordPage(),
          ),
        );

      // ----- Módulos -----
      case ordenes:
        return MaterialPageRoute(builder: (_) => const OrdersPage());

      case proveedores:
        return MaterialPageRoute(builder: (_) => const ProveedoresPage());

      case productos:
        return MaterialPageRoute(builder: (_) => const ProductosPage());

      case existencias:
        return MaterialPageRoute(builder: (_) => const ExistenciasPage());

      case clientes:
        return MaterialPageRoute(builder: (_) => const ClientesPage());

      case usuarios:
        return MaterialPageRoute(builder: (_) => const UsuariosPage());

      case roles:
        return MaterialPageRoute(builder: (_) => const RolesPage());

      case remisiones:
        return MaterialPageRoute(builder: (_) => const RemisionesPage());

      case compras:
        return MaterialPageRoute(builder: (_) => const ComprasPage());

      case bodegas:
        return MaterialPageRoute(builder: (_) => const BodegasPage());

      case traslados:
        return MaterialPageRoute(builder: (_) => const TrasladosPage());

      case pagosAbonos:
        return MaterialPageRoute(builder: (_) => const ReportesPage());

      

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Ruta no encontrada", style: TextStyle(fontSize: 20)),
            ),
          ),
        );
    }
  }
}

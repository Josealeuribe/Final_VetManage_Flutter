import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/pages/login/login_page.dart';
import '../presentation/pages/dashboard/dashboard_page.dart';
import '../presentation/pages/recover_password/recover_password_page.dart';

import '../presentation/blocs/login/login_bloc.dart';
import '../presentation/blocs/recover/recover_bloc.dart';

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String recover = '/recover';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginBloc(),
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
            create: (context) => RecoverBloc(),
            child: const RecoverPasswordPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Ruta no encontrada")),
          ),
        );
    }
  }
}

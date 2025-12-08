import 'package:flutter/material.dart';
import 'config/routes.dart';

void main() {
  runApp(const VManageApp());
}

class VManageApp extends StatelessWidget {
  const VManageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "VManage",
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

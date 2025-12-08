import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login/login_bloc.dart';
import '../../blocs/login/login_event.dart';
import '../../blocs/login/login_state.dart';
import '../dashboard/dashboard_page.dart';
import '../recover_password/recover_password_page.dart';
import '../../blocs/recover/recover_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              // Redirigir al Dashboard
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPage()),
              );
            }

            // Mostrar errores
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },

          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // LOGO SUPERIOR
                  Image.asset(
                    'assets/VManage.png',
                    height: 90,
                  ),

                  const SizedBox(height: 45),

                  // CARD FORMULARIO LOGIN
                  Container(
                    padding: const EdgeInsets.all(22),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Usuario",
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 6),

                        // USERNAME
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return TextField(
                              onChanged: (value) {
                                context.read<LoginBloc>().add(
                                      LoginUsernameChanged(value),
                                    );
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Value",
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Contraseña",
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 6),

                        // PASSWORD
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return TextField(
                              obscureText: true,
                              onChanged: (value) {
                                context.read<LoginBloc>().add(
                                      LoginPasswordChanged(value),
                                    );
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Value",
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 22),

                        // BOTÓN LOGIN
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1E66FF),
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: state.isSubmitting
                                    ? null
                                    : () {
                                        context.read<LoginBloc>().add(
                                              LoginSubmitted(),
                                            );
                                      },
                                child: state.isSubmitting
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text("Iniciar sesión"),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 15),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => RecoverBloc(),
                                  child: const RecoverPasswordPage(),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Recuperar contraseña?",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // LOGO GVM
                  Image.asset(
                    'assets/GVMLogo.png',
                    height: 70,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

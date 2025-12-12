import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login/login_bloc.dart';
import '../../blocs/login/login_event.dart';
import '../../blocs/login/login_state.dart';
import '../dashboard/dashboard_page.dart';
import '../driver/driver_dashboard.dart'; // NUEVA IMPORTACIÓN

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 37, 66, 255),
          automaticallyImplyLeading: false,
        ),
      ),
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              if (state.role == "admin") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const DashboardPage()),
                );
              } else if (state.role == "conductor") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const DriverDashboard()),
                );
              }
            }

            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }

            if (state.isRecoverySuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    "Se ha enviado un link de recuperación a tu correo",
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },

          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/VManage.png', height: 100),
                  const SizedBox(height: 45),

                  // CARD LOGIN
                  Container(
                    padding: const EdgeInsets.all(22),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 10,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Usuario",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),

                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return TextField(
                              onChanged: (value) => context
                                  .read<LoginBloc>()
                                  .add(LoginUsernameChanged(value)),
                              decoration: InputDecoration(
                                hintText: "Ingrese su usuario",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),
                        const Text(
                          "Contraseña",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),

                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return TextField(
                              obscureText: state.isPasswordObscured,
                              onChanged: (value) => context
                                  .read<LoginBloc>()
                                  .add(LoginPasswordChanged(value)),
                              decoration: InputDecoration(
                                hintText: "Ingrese su contraseña",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.blue,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    state.isPasswordObscured
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () => context
                                      .read<LoginBloc>()
                                      .add(TogglePasswordVisibility()),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 22),

                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1E66FF),
                                  foregroundColor: Colors
                                      .white, // <-- Esto asegura texto/blanco e íconos blancos
                                ),
                                onPressed: state.isSubmitting
                                    ? null
                                    : () => context.read<LoginBloc>().add(
                                        LoginSubmitted(),
                                      ),
                                child: state.isSubmitting
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        "Iniciar sesión",
                                        style: TextStyle(
                                          color:
                                              Colors.white, // <-- Texto blanco
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 15),

                        GestureDetector(
                          onTap: () {
                            if (context
                                .read<LoginBloc>()
                                .state
                                .username
                                .isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Digite primero un usuario"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              context.read<LoginBloc>().add(
                                PasswordRecoveryRequested(),
                              );
                            }
                          },
                          child: const Text(
                            "¿Olvidaste tu contraseña?",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                  Image.asset('assets/GVMLogo.png', height: 70),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 37, 66, 255),
        height: 50,
        child: const Center(
          child: Text(
            "v.1.0.0",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

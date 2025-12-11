import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login/login_bloc.dart';
import '../../blocs/login/login_event.dart';
import '../../blocs/login/login_state.dart';
import '../dashboard/dashboard_page.dart';
import '../../blocs/recover/recover_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 37, 66, 255), // Color del header
          automaticallyImplyLeading: false, // Elimina el botón de "volver"
        ),
      ),
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            // Verificamos si el login fue exitoso
            if (state.isSuccess) {
              // Redirigir al Dashboard
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPage()),
              );
            }

            // Mostrar errores si los hay
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }

            // Mostrar éxito de recuperación de contraseña
            if (state.isRecoverySuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Se ha enviado un link de recuperación a tu correo"),
                  backgroundColor: Colors.green,
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
                    height: 100, // Ajustamos el tamaño
                  ),

                  const SizedBox(height: 45),

                  // CARD FORMULARIO LOGIN
                  Container(
                    padding: const EdgeInsets.all(22),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), // Más redondeado
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4), // Más sombra
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
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),

                        // USERNAME con icono
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return TextField(
                              onChanged: (value) {
                                context.read<LoginBloc>().add(
                                      LoginUsernameChanged(value),
                                    );
                              },
                              decoration: InputDecoration(
                                hintText: "Ingrese su usuario",
                                prefixIcon: Icon(Icons.person, color: Colors.blue),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.blue),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Contraseña",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),

                        // PASSWORD con icono
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return TextField(
                              obscureText: state.isPasswordObscured,
                              onChanged: (value) {
                                context.read<LoginBloc>().add(
                                      LoginPasswordChanged(value),
                                    );
                              },
                              decoration: InputDecoration(
                                hintText: "Ingrese su contraseña",
                                prefixIcon: Icon(Icons.lock, color: Colors.blue),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    state.isPasswordObscured
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    context.read<LoginBloc>().add(TogglePasswordVisibility()); // Alternar visibilidad
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.blue),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16),
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
                                  backgroundColor: const Color(0xFF1E66FF), // Color del botón
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
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

                        // ENLACE PARA RECUPERAR CONTRASEÑA
                        GestureDetector(
                          onTap: () {
                            // Validar si el usuario está vacío antes de proceder con la recuperación de contraseña
                            if (context.read<LoginBloc>().state.username.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Digite primero un usuario"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              context.read<LoginBloc>().add(PasswordRecoveryRequested());
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

      // Footer
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 37, 66, 255), // Verde como en el logo
        height: 50,
        child: Center(
          child: const Text(
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

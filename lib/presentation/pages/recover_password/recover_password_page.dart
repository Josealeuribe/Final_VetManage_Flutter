import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/recover/recover_bloc.dart';
import '../../blocs/recover/recover_event.dart';
import '../../blocs/recover/recover_state.dart';

class RecoverPasswordPage extends StatelessWidget {
  const RecoverPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: BlocListener<RecoverBloc, RecoverState>(
          listener: (context, state) {
            if (state.isSuccess) {
              // Mostrar mensaje
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Correo enviado con éxito."),
                  backgroundColor: Colors.green,
                ),
              );

              // Regresar al login después de un momento
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pop(context);
              });
            }

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

                  const SizedBox(height: 35),

                  // CARD DEL FORMULARIO
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ingresa correo para recuperar contraseña",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        BlocBuilder<RecoverBloc, RecoverState>(
                          builder: (context, state) {
                            return TextField(
                              onChanged: (value) {
                                context.read<RecoverBloc>().add(
                                      RecoverEmailChanged(value),
                                    );
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: "Correo",
                                border: OutlineInputBorder(),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 22),

                        // BOTONES
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancelar"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: BlocBuilder<RecoverBloc, RecoverState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1E66FF),
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: state.isSubmitting
                                        ? null
                                        : () {
                                            context
                                                .read<RecoverBloc>()
                                                .add(RecoverSubmitted());
                                          },
                                    child: state.isSubmitting
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                                color: Colors.white, strokeWidth: 2),
                                          )
                                        : const Text("Enviar"),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Volver"),
                  ),

                  const SizedBox(height: 25),

                  // LOGO GVM
                  Image.asset(
                    'assets/GVMLogo.png',
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<PasswordRecoveryRequested>(_onPasswordRecoveryRequested);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);  // Manejo del evento Toggle
  }

  // Actualizamos el nombre de usuario
  void _onUsernameChanged(
      LoginUsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(username: event.username));
  }

  // Actualizamos la contraseña
  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  // Verificamos si las credenciales son correctas
  Future<void> _onSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.username.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(errorMessage: "Complete todos los campos"));
      return;
    }

    // Indicamos que estamos procesando el login
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    // Simulamos un retraso para el proceso de login
    await Future.delayed(const Duration(seconds: 2));

    // Comprobamos si las credenciales son correctas
    if (state.username == "admin" && state.password == "1234") {
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } else {
      // Si las credenciales son incorrectas, mostramos el mensaje de error
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: "Credenciales incorrectas",
      ));
    }
  }

  // Manejo de la solicitud de recuperación de contraseña
  Future<void> _onPasswordRecoveryRequested(
      PasswordRecoveryRequested event, Emitter<LoginState> emit) async {
    // Si ya está en progreso la recuperación, no hacer nada más
    if (state.isRecoveryInProgress) return;

    // Simulamos un proceso de recuperación de contraseña
    await Future.delayed(const Duration(seconds: 2));

    // Aquí, en el caso de éxito, podrías cambiar el estado
    emit(state.copyWith(isRecoverySuccess: true, isRecoveryInProgress: true));

    // Restablecer isRecoverySuccess a false después de un breve delay, para evitar alertas continuas
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(isRecoverySuccess: false));
  }

  // Manejamos el evento de alternar visibilidad de la contraseña
  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }
}

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
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  void _onUsernameChanged(
      LoginUsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.username.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(errorMessage: "Complete todos los campos"));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    await Future.delayed(const Duration(seconds: 2));

    /// SIMULACIÓN DE LOGIN CON ROLES
    if (state.username == "admin" && state.password == "1234") {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
        role: "admin",
      ));
    } else if (state.username == "driver" && state.password == "0000") {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
        role: "conductor",
      ));
    } else {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: "Credenciales incorrectas",
      ));
    }
  }

  Future<void> _onPasswordRecoveryRequested(
      PasswordRecoveryRequested event, Emitter<LoginState> emit) async {
    if (state.isRecoveryInProgress) return;

    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(isRecoverySuccess: true, isRecoveryInProgress: true));

    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(isRecoverySuccess: false));
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }
}

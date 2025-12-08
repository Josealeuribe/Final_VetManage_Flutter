import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
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

    if (state.username == "admin" && state.password == "1234") {
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } else {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: "Credenciales incorrectas",
      ));
    }
  }
}

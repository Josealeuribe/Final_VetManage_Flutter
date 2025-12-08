import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'recover_event.dart';
import 'recover_state.dart';

class RecoverBloc extends Bloc<RecoverEvent, RecoverState> {
  RecoverBloc() : super(const RecoverState()) {
    
    on<RecoverEmailChanged>(_onEmailChanged);
    on<RecoverSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(
    RecoverEmailChanged event,
    Emitter<RecoverState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onSubmitted(
    RecoverSubmitted event,
    Emitter<RecoverState> emit,
  ) async {
    if (state.email.isEmpty || !state.email.contains("@")) {
      emit(
        state.copyWith(errorMessage: "Ingrese un correo válido"),
      );
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      // Simular llamada al backend
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: "Hubo un error al enviar el correo",
        ),
      );
    }
  }
}

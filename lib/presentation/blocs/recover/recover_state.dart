import 'package:equatable/equatable.dart';

class RecoverState extends Equatable {
  final String email;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const RecoverState({
    this.email = "",
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  RecoverState copyWith({
    String? email,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RecoverState(
      email: email ?? this.email,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage, // reemplaza el anterior
    );
  }

  @override
  List<Object?> get props => [email, isSubmitting, isSuccess, errorMessage];
}

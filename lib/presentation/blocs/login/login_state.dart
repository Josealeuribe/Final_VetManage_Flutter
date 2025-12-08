import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const LoginState({
    this.username = "",
    this.password = "",
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  LoginState copyWith({
    String? username,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        isSubmitting,
        isSuccess,
        errorMessage,
      ];
}

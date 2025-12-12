class LoginState {
  final String username;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;
  final bool isRecoverySuccess;
  final bool isRecoveryInProgress;
  final bool isPasswordObscured;

  /// NUEVO → rol del usuario
  final String role; // "admin" o "conductor"

  LoginState({
    this.username = '',
    this.password = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
    this.isRecoverySuccess = false,
    this.isRecoveryInProgress = false,
    this.isPasswordObscured = true,
    this.role = '', // Por defecto vacío
  });

  LoginState copyWith({
    String? username,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool? isRecoverySuccess,
    bool? isRecoveryInProgress,
    bool? isPasswordObscured,
    String? role,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      isRecoverySuccess: isRecoverySuccess ?? this.isRecoverySuccess,
      isRecoveryInProgress: isRecoveryInProgress ?? this.isRecoveryInProgress,
      isPasswordObscured:
          isPasswordObscured ?? this.isPasswordObscured,
      role: role ?? this.role,
    );
  }
}

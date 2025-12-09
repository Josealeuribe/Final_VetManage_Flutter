class LoginState {
  final String username;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;
  final bool isRecoverySuccess;
  final bool isRecoveryInProgress;
  final bool isPasswordObscured;  // Control para mostrar/ocultar contraseña

  // Constructor con la nueva propiedad
  LoginState({
    this.username = '',
    this.password = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
    this.isRecoverySuccess = false,
    this.isRecoveryInProgress = false,
    this.isPasswordObscured = true, // Inicializa la contraseña como oculta
  });

  // Método copyWith para actualizar el estado
  LoginState copyWith({
    String? username,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool? isRecoverySuccess,
    bool? isRecoveryInProgress,
    bool? isPasswordObscured,  // Para cambiar el estado de visibilidad de la contraseña
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      isRecoverySuccess: isRecoverySuccess ?? this.isRecoverySuccess,
      isRecoveryInProgress: isRecoveryInProgress ?? this.isRecoveryInProgress,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,  // Actualiza este estado
    );
  }
}

import 'package:equatable/equatable.dart';
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {}

class LoginUsernameChanged extends LoginEvent {
  final String username;
  LoginUsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class PasswordRecoveryRequested extends LoginEvent {}

class TogglePasswordVisibility extends LoginEvent {}  // Evento para alternar la visibilidad de la contraseña

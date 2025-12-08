import 'package:equatable/equatable.dart';

abstract class RecoverEvent extends Equatable {
  const RecoverEvent();

  @override
  List<Object?> get props => [];
}

class RecoverEmailChanged extends RecoverEvent {
  final String email;

  const RecoverEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class RecoverSubmitted extends RecoverEvent {}

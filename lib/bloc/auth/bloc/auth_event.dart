part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthLogin extends AuthEvent {
  const AuthLogin({required this.email, required this.password});
  final String email;
  final String password;
  @override
  List<Object?> get props => [email, password];
}

class AuthRegister extends AuthEvent {
  const AuthRegister(
      {required this.name,
      required this.subject,
      required this.email,
      required this.password});
  final String email;
  final String name;
  final String subject;
  final String password;
  @override
  List<Object?> get props => [email, password, name, subject];
}

class AuthGoogle extends AuthEvent {
  const AuthGoogle();

  @override
  List<Object?> get props => [];
}

class AuthLogOut extends AuthEvent {
  const AuthLogOut();

  @override
  List<Object?> get props => [];
}

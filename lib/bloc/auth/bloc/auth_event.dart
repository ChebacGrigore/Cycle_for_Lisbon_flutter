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

class AuthProfileUpdate extends AuthEvent {
  const AuthProfileUpdate({
    required this.token,
    required this.userProfile,
    required this.id,
  });
  final String token;
  final String id;
  final UserUpdate userProfile;
  @override
  List<Object?> get props => [token, userProfile, id];
}

class AuthPasswordReset extends AuthEvent {
  const AuthPasswordReset({
    required this.token,
    required this.email,
  });
  final String token;
  final String email;
  @override
  List<Object?> get props => [token, email];
}

class AuthPasswordUpdate extends AuthEvent {
  const AuthPasswordUpdate({
    required this.token,
    required this.newPassword,
    required this.oldPassword,
  });
  final String token;
  final String newPassword;
  final String oldPassword;
  @override
  List<Object?> get props => [token, newPassword, oldPassword];
}

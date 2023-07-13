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

class AuthGoogleAuthorization extends AuthEvent {
  const AuthGoogleAuthorization({required this.code});
  final String code;

  @override
  List<Object?> get props => [code];
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

class AuthProfilePictureUpload extends AuthEvent {
  const AuthProfilePictureUpload({
    required this.token,
    required this.id,
    required this.imageByte,
  });
  final String token;
  final String id;
  final List<int> imageByte;
  @override
  List<Object?> get props => [token, id, imageByte];
}

class AuthGetProfile extends AuthEvent {
  const AuthGetProfile({
    required this.id,
    required this.token,
  });
  final String id;
  final String token;
  @override
  List<Object?> get props => [id, token];
}

class AuthDeleteAccount extends AuthEvent {
  const AuthDeleteAccount({
    required this.id,
    required this.token,
  });
  final String id;
  final String token;
  @override
  List<Object?> get props => [id, token];
}

class AuthPasswordReset extends AuthEvent {
  const AuthPasswordReset({
    required this.email,
  });
  final String email;
  @override
  List<Object?> get props => [email];
}

class AuthConfirmPasswordReset extends AuthEvent {
  const AuthConfirmPasswordReset(
      {required this.code, required this.newPassword});
  final String code;
  final String newPassword;
  @override
  List<Object?> get props => [code, newPassword];
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

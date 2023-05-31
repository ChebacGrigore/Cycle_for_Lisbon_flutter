part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  registered,
  authenticated,
  error,
  loading,
  logout,
  profileUpdated,
  passwordRest,
  passwordUpdated,
}

extension AuthStatusX on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isRegistered => this == AuthStatus.registered;
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isProfileUpdated => this == AuthStatus.profileUpdated;
  bool get isPasswordUpdated => this == AuthStatus.passwordUpdated;
  bool get isPasswordReset => this == AuthStatus.passwordRest;
  bool get isError => this == AuthStatus.error;
  bool get isLoading => this == AuthStatus.loading;
  bool get isLogout => this == AuthStatus.logout;
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.exception,
    this.token,
  });

  final User? user;
  final String? token;
  final String? exception;
  final AuthStatus status;

  AuthState copyWith({
    User? user,
    AuthStatus? status,
    String? exception,
    String? token,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
      exception: exception ?? this.exception,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [user, exception, status];
}

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
  confirmPasswordRest,
  passwordUpdated,
  userProfile,
  profilePicture,
  deleteAccount,
}

extension AuthStatusX on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isRegistered => this == AuthStatus.registered;
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isProfileUpdated => this == AuthStatus.profileUpdated;
  bool get isUserProfile => this == AuthStatus.userProfile;
  bool get isProfilePicture => this == AuthStatus.profilePicture;
  bool get isPasswordUpdated => this == AuthStatus.passwordUpdated;
  bool get isPasswordReset => this == AuthStatus.passwordRest;
  bool get isConfirmPasswordReset => this == AuthStatus.confirmPasswordRest;
  bool get isDeleteAccount => this == AuthStatus.deleteAccount;
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
    this.profilePic,
  });

  final User? user;
  final String? token;
  final String? exception;
  final String? profilePic;
  final AuthStatus status;

  AuthState copyWith({
    User? user,
    String? profilePic,
    AuthStatus? status,
    String? exception,
    String? token,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
      exception: exception ?? this.exception,
      token: token ?? this.token,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  @override
  List<Object?> get props => [user, exception, status];
}

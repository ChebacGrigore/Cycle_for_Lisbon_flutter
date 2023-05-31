class RegistrationException implements Exception {
  final String message;

  RegistrationException(this.message);

  @override
  String toString() => message;
}

class UpdatePasswordException implements Exception {
  final String message;

  UpdatePasswordException(this.message);

  @override
  String toString() => message;
}

class ResetPasswordException implements Exception {
  final String message;

  ResetPasswordException(this.message);

  @override
  String toString() => message;
}

class RegistrationException implements Exception {
  final String message;

  RegistrationException(this.message);

  @override
  String toString() => 'RegistrationException: $message';
}

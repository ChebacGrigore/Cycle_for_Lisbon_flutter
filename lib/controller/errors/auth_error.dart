import 'dart:convert';

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

class Error implements Exception {
  final String code;
  final String message;

  Error({
    required this.code,
    required this.message,
  });

  factory Error.fromRawJson(String str) => Error.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

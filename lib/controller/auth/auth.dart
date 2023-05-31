import 'dart:convert';

import 'package:cfl/controller/api_service.dart';
import 'package:cfl/controller/errors/auth_error.dart';
import 'package:cfl/models/user.model.dart';
import 'package:cfl/shared/configs/url_config.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'auth.g.dart';

@riverpod
registerUser(
  RegisterUserRef ref, {
  required String email,
  required String password,
  required String fName,
  required String lName,
  String? subject,
}) async {
  try {
    final fullName = '$fName $lName';
    final res = await ApiService().postRequest(
      'users',
      body: {
        "email": email,
        "name": fullName,
        "password": password,
        "subject": subject ?? "",
      },
    );

    debugPrint(
        'here we go TEST 1 REQ: $res RES: {$email , $fullName $password $subject}');
    return res;
  } catch (e) {
    debugPrint('an Error occured $e');

    return null;
  }
}

class AuthService {
  Future<User> register({
    required String email,
    required String password,
    required String subject,
    required String name,
  }) async {
    final url = Uri.parse('$baseUrl/users');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'email': email,
      'password': password,
      'subject': subject,
      'name': name,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        return User.fromJson(jsonResponse);
      } else {
        final res = jsonDecode(response.body);
        throw RegistrationException('${res['error']['message']}');
      }
    } catch (e) {
      throw RegistrationException('$e');
    }
  }

  Future<String> login(
      {required String email,
      required String password,
      required String clientId,
      required String clientSecret}) async {
    final url = Uri.parse('$domain/dex/token');
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = {
      'grant_type': 'password',
      'username': email,
      'password': password,
      'client_id': clientId,
      'client_secret': clientSecret,
      'scope': 'openid profile email offline_access',
    };

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final accessToken = json['access_token'] as String;
        return accessToken;
      } else {
        final res = jsonDecode(response.body);
        throw Exception('${res['error_description']}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<User> updateUser({
    required String userId,
    required String accessToken,
    required UserUpdate userUpdate,
  }) async {
    final url = Uri.parse('$baseUrl/users/$userId');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final body = jsonEncode(userUpdate.toJson());

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return User.fromJson(jsonResponse);
      } else {
        final res = jsonDecode(response.body);
        throw Exception('${res['error_description']}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<bool> updatePassword({
    required String accessToken,
    required String newPassword,
    required String oldPassword,
  }) async {
    final url = Uri.parse('$baseUrl/password');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final body = jsonEncode({
      'new': newPassword,
      'old': oldPassword,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 204) {
        return true;
      } else {
        final jsonResponse = jsonDecode(response.body);
        final errorMessage =
            jsonResponse['error']['message'] ?? 'Unknown error';
        throw UpdatePasswordException(errorMessage);
      }
    } catch (e) {
      throw UpdatePasswordException('$e');
    }
  }

  Future<bool> resetPassword({
    required String accessToken,
    required String email,
  }) async {
    final url = Uri.parse('$baseUrl/password/reset');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final body = jsonEncode({
      'email': email,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 204) {
        return true;
      } else {
        final jsonResponse = jsonDecode(response.body);
        final errorMessage =
            jsonResponse['error']['message'] ?? 'Unknown error';
        throw ResetPasswordException(errorMessage);
      }
    } catch (e) {
      throw ResetPasswordException('$e');
    }
  }
}

import 'dart:io';

import 'package:cfl/controller/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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

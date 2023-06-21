import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:cfl/controller/errors/auth_error.dart';
import 'package:cfl/models/picture.model.dart';
import 'package:cfl/models/user.model.dart';
import 'package:cfl/routes/app_route.dart';
import 'package:cfl/routes/app_route_paths.dart';
import 'package:cfl/shared/configs/url_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> saveTokensToLocalStorage(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<String?> getTokenFromLocalStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  return token;
}

class AuthService {
  Future<bool> register({
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
        return true;
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
        final refreshToken = json['refresh_token'] as String;
        final token =
            Token(accessToken: accessToken, refreshToken: refreshToken);
        saveTokensToLocalStorage(
          token.toRawJson(),
        );
        return accessToken;
      } else {
        final res = jsonDecode(response.body);
        throw Exception('${res['error_description']}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<bool> createUserSocialLogin(
      {required String identificationToken}) async {
    // Create a new user with the identification token
    try {
      final url = Uri.parse('$baseUrl/users');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $identificationToken',
          'Content-Type': 'application/json',
        },
        body: '{"sub": "$identificationToken"}',
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        final res = jsonDecode(response.body);
        throw RegistrationException('${res['error']['message']}');
      }
    } catch (e) {
      throw RegistrationException(e.toString());
    }
  }

  Future<void> signInWithGoogle({required String clientId}) async {
    try {
      const redirectUrl = 'cfl://login-callback';
      final apiUrl = Uri.parse('$domain/dex/auth/google');
      final queryParams = {
        'response_type': 'code',
        'scope': 'openid profile email offline_access',
        'client_id': clientId,
        'state': 'samplestaste',
        'redirect_uri': redirectUrl,
      };
      final url = apiUrl.replace(queryParameters: queryParams);

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch the OAuth redirect URL';
      }
    } catch (error) {
      throw Exception('Failed to sign in with Google: $error');
    }
  }

  Future<String> handleTokenRequest(
      {required String code,
      required String clientId,
      required String clientSecret}) async {
    try {
      final apiUrl = Uri.parse('$domain/dex/token');
      final response = await http.post(apiUrl, body: {
        'grant_type': 'authorization_code',
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': code,
        'redirect_uri': 'cfl://login-callback',
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final accessToken = json['access_token'] as String;
        final refreshToken = json['refresh_token'] as String;
        final token =
            Token(accessToken: accessToken, refreshToken: refreshToken);
        saveTokensToLocalStorage(
          token.toRawJson(),
        );
        return accessToken;
      } else {
        final res = jsonDecode(response.body);
        print(res['error_description']);
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

  Future<bool> resetPassword({required String email}) async {
    final url = Uri.parse('$baseUrl/password/reset');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'email': email,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 202) {
        return true;
      } else {
        final jsonResponse = jsonDecode(response.body);
        final errorMessage =
            jsonResponse['error']['message'] ?? 'Unknown error';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<bool> confirlResetPassword(
      {required String code, required String newPassword}) async {
    final url = Uri.parse('$baseUrl/password/confirm-reset');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'code': code,
      'new': newPassword,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 204) {
        return true;
      } else {
        final jsonResponse = jsonDecode(response.body);
        final errorMessage =
            jsonResponse['error']['message'] ?? 'Unknown error';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<User> getUser({required String accessToken}) async {
    final url = Uri.parse('$baseUrl/users/current');
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'accept': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final user = User(
          createdAt: DateTime.parse(jsonBody['createdAt']),
          updatedAt: DateTime.parse(jsonBody['updatedAt']),
          email: jsonBody['email'],
          id: jsonBody['id'],
          name: jsonBody['name'] ?? '',
          subject: jsonBody['subject'],
          username: jsonBody['username'] ?? 'N/A',
          verified: jsonBody['verified'],
        );
        return user;
      } else {
        if (response.statusCode == 401) {
          final jsonResponse = jsonDecode(response.body);
          final errorMessage = jsonResponse['error']['message'];
          throw Exception('$errorMessage');
        } else {
          final jsonResponse = jsonDecode(response.body);
          final errorMessage = jsonResponse['error']['message'];
          throw Exception('$errorMessage');
        }
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<Picture> getUrlToUploadProfilePicture(
      {required String id, required String accessToken}) async {
    final url = '$baseUrl/users/$id/picture-put-url';
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return Picture.fromJson(responseBody);
      } else {
        if (response.statusCode == 401) {
          final jsonResponse = jsonDecode(response.body);
          throw Error.fromJson(jsonResponse['error']['message']);
        } else {
          final jsonResponse = jsonDecode(response.body);
          final errorMessage = jsonResponse['error']['message'];
          throw Exception('$errorMessage');
        }
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<Picture> getProfilePictureUrl(
      {required String id, required String accessToken}) async {
    final url = '$baseUrl/users/$id/picture-get-url';
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return Picture.fromJson(responseBody);
      } else {
        if (response.statusCode == 401) {
          final jsonResponse = jsonDecode(response.body);
          throw Error.fromJson(jsonResponse['error']['message']);
        } else {
          final jsonResponse = jsonDecode(response.body);
          final errorMessage = jsonResponse['error']['message'];
          throw Exception('$errorMessage');
        }
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<bool> uploadProfilePicture(
      {required Uri url, required List<int> imageBytes}) async {
    try {
      final headers = {
        'Content-Type': 'image/png',
      };
      final request = http.Request('PUT', url);
      request.bodyBytes = imageBytes;
      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
          'Failed to upload picture. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  void initForgotPasswordDeepLinkHandling() {
    AppLinks().allStringLinkStream.listen((uri) {
      handleDeepLink(uri);
    });
  }

  void initSocialAuthDeepLinkHandling() {
    AppLinks().allStringLinkStream.listen((uri) {
      handleRedirect(uri);
    });
  }

  void handleDeepLink(String? uri) {
    if (uri != null &&
        uri.contains('api.cycleforlisbon.com') &&
        uri.contains('/api/password/redirect-reset')) {
      String? code = uri.split('code=')[1];
      appRoutes.go('${AppRoutePath.signin}/$code?deepLink=true');
    }
  }

  void handleRedirect(String? uri) {
    if (uri != null && uri.startsWith('cfl://login-callback')) {
      String? code = uri.split('code=')[1].split('&')[0];
      appRoutes.go('${AppRoutePath.splash}/$code?redirect=true');
    }
  }
}

AuthService auth = AuthService();

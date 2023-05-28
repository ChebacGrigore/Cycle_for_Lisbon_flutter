import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final baseUrl = 'https://api.cycleforlisbon.com/api';

  Future<dynamic> getRequest({
    required String endpoint,
    Map<String, String>? headers,
    String? param,
  }) async {
    Uri uri = Uri.parse('$baseUrl/$endpoint?$param');
    http.Response res = await http.get(uri, headers: headers);
    return _processResponse(res);
  }

  Future<dynamic> postRequest(
    String endpoint, {
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    Uri uri = Uri.parse('$baseUrl/$endpoint');
    http.Response res = await http.post(
      uri,
      body: body,
    );
    return _processResponse(res);
  }

  Future<dynamic> putRequest(
    String endpoint, {
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    Uri uri = Uri.parse('$baseUrl/$endpoint');
    http.Response res = await http.put(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    return _processResponse(res);
  }

  Future<dynamic> deleteRequest(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    Uri uri = Uri.parse('$baseUrl/$endpoint');
    http.Response res = await http.delete(
      uri,
      headers: headers,
    );
    return _processResponse(res);
  }

  Future<dynamic> patchRequest(
    String endpoint, {
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    Uri uri = Uri.parse('$baseUrl/$endpoint');
    http.Response res = await http.patch(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    return _processResponse(res);
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Request failed with status code ${response.statusCode}');
    }
  }

  Future<String> getToken(String domain, String email, String password,
      String clientId, String clientSecret) async {
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
        return response.body;
      } else {
        throw Exception('Failed to get token: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get token: $e');
    }
  }
}

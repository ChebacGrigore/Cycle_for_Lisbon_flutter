import 'dart:convert';

import 'package:cfl/models/initiative.model.dart';
import 'package:cfl/shared/configs/url_config.dart';
import 'package:http/http.dart' as http;

class InitiativeService {
  Future<List<Initiative>> getInitiatives({required String accessToken}) async {
    final url = Uri.parse('$baseUrl/initiatives?orderBy=id%20asc');
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    List<Initiative> initiatives = [];
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        for (final initiative in json) {
          initiatives.add(Initiative.fromJson(initiative));
        }
        return initiatives;
      } else {
        final res = jsonDecode(response.body);
        throw Exception('${res['error']['message']}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}

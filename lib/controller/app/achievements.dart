import 'dart:convert';

import 'package:cfl/models/acheivement.model.dart';
import 'package:cfl/shared/configs/url_config.dart';
import 'package:http/http.dart' as http;

Future<List<Achievement>> fetchAchievements(String token) async {
  final url = Uri.parse('$baseUrl/users/achievements');

  final headers = {
    'Authorization': 'Bearer $token',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body) as List<dynamic>;

    final achievements = jsonData.map((achievementData) {
      return Achievement.fromJson(achievementData);
    }).toList();

    return achievements;
  } else {
    throw Exception('Request failed with status: ${response.statusCode}');
  }
}

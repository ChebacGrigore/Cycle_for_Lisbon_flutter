import 'dart:convert';

import 'package:cfl/models/acheivement.model.dart';
import 'package:cfl/shared/configs/url_config.dart';
import 'package:http/http.dart' as http;

Future<List<Badge>> allAchievements({required String token}) async {
  List<Badge> badges = [];
  try{
    final url = Uri.parse('$baseUrl/users/achievements');

    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      for (final badge in json) {
        badges.add(Badge.fromJson(badge));
      }
      return badges;
    } else {
      final res = jsonDecode(response.body);
      throw Exception('${res['error']['message']}');
    }
  }catch (e){
    print(e.toString());
    throw Exception(e.toString());
  }
}

Future<List<Achievement>> getAllAchievements({required String token}) async {
  List<Achievement> achievement = [];
  try{
    final url = Uri.parse('$baseUrl/achievements');

    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      for (final badge in json) {
        achievement.add(Achievement.fromJson(badge));
      }
      return achievement;
    } else {
      final res = jsonDecode(response.body);
      throw Exception('${res['error']['message']}');
    }
  }catch (e){
    print(e.toString());
    throw Exception(e.toString());
  }
}

Future<Leaderboard> leaderboard({required String token}) async {
  String url = '$baseUrl/leaderboard';

  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
  };

  try {
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return Leaderboard.fromJson(jsonMap);
    } else {
      final res = jsonDecode(response.body);
      throw Exception('${res['error']['message']}');
    }
  } catch (e) {
    print(e.toString());
    throw Exception(e.toString());
  }
}

import 'dart:convert';

import 'package:cfl/models/initiative.model.dart';
import 'package:cfl/shared/configs/url_config.dart';
import 'package:http/http.dart' as http;

import '../../models/user.model.dart';

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
    } catch (e, stack) {
      throw Exception('$e');
    }
  }

  Future<Initiative> getSingleInitiative({required String accessToken, required String id}) async {
    final url = Uri.parse('$baseUrl/initiatives/$id');
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'accept': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body) as Map<String, dynamic>;
        return Initiative.fromJson(jsonBody);
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
      print(e);
      throw Exception('$e');
    }
  }


  Future<List<EventModel>> getAllEvents({required String token}) async {
    List<EventModel> events = [];
    try{
      final url = Uri.parse('$baseUrl/external?orderBy=id%20asc&type=event');
      final response = await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        // return jsonList.map((e) => EventModel.fromJson(e)).toList();
        for (final event in jsonList) {
          events.add(EventModel.fromJson(event));
        }
        return events;
      } else {
        final res = jsonDecode(response.body);
        throw Exception('${res['error']['message']}');
      }
    }catch(e){
      throw Exception('Failed to fetch events ${e.toString()}');
    }
  }

  Future<List<NewsModel>> getAllNews({required String token}) async {
    List<NewsModel> news = [];
    try{
      final url = Uri.parse('$baseUrl/external?orderBy=id%20asc&type=news');
      final response = await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        // return jsonList.map((e) => EventModel.fromJson(e)).toList();
        for (final event in jsonList) {
          news.add(NewsModel.fromJson(event));
        }
        return news;
      } else {
        final res = jsonDecode(response.body);
        throw Exception('${res['error']['message']}');
      }
    }catch(e){
      throw Exception('Failed to fetch events ${e.toString()}');
    }
  }

  Future<User> supportInitiative({
    required String userId,
    required String initiativeId,
    required String accessToken,
    required User user,
  }) async {
    final url = Uri.parse('$baseUrl/users/$userId');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final body = jsonEncode(
        {
          "birthday": user.birthday,
          "email": user.email,
          "gender": user.gender,
          "name": user.name,
          "username": user.username,
          "initiativeId": initiativeId,
        }
    );

    try {
      final response = await http.put(url, headers: headers, body: body);
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        // await auth.saveToLocalStorage(key: 'initiativeId', value: jsonResponse['initiativeId']);
        return User.fromJson(jsonResponse);
      } else {
        final res = jsonDecode(response.body);
        throw Exception('${res['error_description']}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('$e');
    }
  }
}

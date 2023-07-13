import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trip {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double distance;
  final double duration;
  final num durationInMotion;
  final String userId;

  Trip({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.distance,
    required this.duration,
    required this.durationInMotion,
    required this.userId,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      distance: json['distance'].toDouble(),
      duration: json['duration'].toDouble(),
      durationInMotion: json['durationInMotion'],
      userId: json['userId'],
    );
  }
}

class TripHistory {
  final String? initiativeName;
  final TripModel trip;

  TripHistory({
    this.initiativeName,
    required this.trip,
  });
}

class TripModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double? startLat;
  final double? startLon;
  final double? endLat;
  final double? endLon;
  final String? startAddr;
  final String? endAddr;
  final bool isValid;
  final double distance;
  final double credits;
  final double duration;
  final double durationInMotion;
  final String userId;
  final String? initiativeId;

  TripModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.startLat,
    this.startLon,
    this.endLat,
    this.endLon,
    this.startAddr,
    this.endAddr,
    required this.isValid,
    required this.distance,
    required this.credits,
    required this.duration,
    required this.durationInMotion,
    required this.userId,
    this.initiativeId,
  });

  factory TripModel.fromRawJson(String str) =>
      TripModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        startLat: json["startLat"]?.toDouble() ?? 0.0,
        startLon: json["startLon"]?.toDouble() ?? 0.0,
        endLat: json["endLat"]?.toDouble() ?? 0.0,
        endLon: json["endLon"]?.toDouble() ?? 0.0,
        startAddr: json["startAddr"] ?? 'N/A',
        endAddr: json["endAddr"] ?? 'N/A',
        isValid: json["isValid"],
        distance: json["distance"]?.toDouble(),
        credits: json["credits"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        durationInMotion: json["durationInMotion"]?.toDouble(),
        userId: json["userId"],
        initiativeId: json["initiativeId"] ?? 'N/A',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "startLat": startLat,
        "startLon": startLon,
        "endLat": endLat,
        "endLon": endLon,
        "startAddr": startAddr,
        "endAddr": endAddr,
        "isValid": isValid,
        "distance": distance,
        "credits": credits,
        "duration": duration,
        "durationInMotion": durationInMotion,
        "userId": userId,
        "initiativeId": initiativeId,
      };
}

class POI {
  final String id;
  final String name;
  final String type;
  final double lat;
  final double lon;
  final DateTime createdAt;
  final DateTime updatedAt;

  POI({
    required this.id,
    required this.name,
    required this.type,
    required this.lat,
    required this.lon,
    required this.createdAt,
    required this.updatedAt,
  });

  factory POI.fromJson(Map<String, dynamic> json) {
    return POI(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class LastRide {
  final TripModel trip;
  final List<LatLng> points;
  LastRide({required this.trip, required this.points });
}

import 'dart:convert';

class Trip {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double distance;
  final int duration;
  final int durationInMotion;
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
      duration: json['duration'],
      durationInMotion: json['durationInMotion'],
      userId: json['userId'],
    );
  }
}

class TripModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isValid;
  final double distance;
  final int credits;
  final int duration;
  final int durationInMotion;
  final String userId;

  TripModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.isValid,
    required this.distance,
    required this.credits,
    required this.duration,
    required this.durationInMotion,
    required this.userId,
  });

  factory TripModel.fromRawJson(String str) =>
      TripModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        isValid: json["isValid"],
        distance: json["distance"]?.toDouble(),
        credits: json["credits"],
        duration: json["duration"],
        durationInMotion: json["durationInMotion"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "isValid": isValid,
        "distance": distance,
        "credits": credits,
        "duration": duration,
        "durationInMotion": durationInMotion,
        "userId": userId,
      };
}

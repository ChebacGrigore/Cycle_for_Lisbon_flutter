import 'dart:convert';

class Badge {
  final String userId;
  final String achievementCode;
  final Achievement achievement;
  final double completion;
  final bool achieved;

  Badge({
    required this.userId,
    required this.achievementCode,
    required this.achievement,
    required this.completion,
    required this.achieved,
  });

  factory Badge.fromRawJson(String str) => Badge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
    userId: json["userID"],
    achievementCode: json["achievementCode"],
    achievement: Achievement.fromJson(json["achievement"]),
    completion: double.parse(json["completion"].toString()),
    achieved: json["achieved"],
  );

  Map<String, dynamic> toJson() => {
    "userID": userId,
    "achievementCode": achievementCode,
    "achievement": achievement.toJson(),
    "completion": completion,
    "achieved": achieved,
  };
}

class Achievement {
  final String code;
  final String imageUri;
  final String name;
  final String desc;
  final String image;

  Achievement({
    required this.code,
    required this.imageUri,
    required this.name,
    required this.desc,
    required this.image,
  });

  factory Achievement.fromRawJson(String str) => Achievement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
    code: json["code"],
    imageUri: json["imageURI"],
    name: json["name"],
    desc: json["desc"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "imageURI": imageUri,
    "name": name,
    "desc": desc,
    "image": image,
  };
}


class Leaderboard {
  List<Entry> entries;
  int userPosition;

  Leaderboard({ required this.entries, required this.userPosition});

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      entries: (json['entries'] as List)
          .map((entryJson) => Entry.fromJson(entryJson))
          .toList(),
      userPosition: json['userPosition'],
    );
  }
}

class Entry {
  int position;
  String userId;
  String? name;
  String? username;
  int tripCount;
  double totalDist;
  double credits;

  Entry({
    required this.position,
    required this.userId,
    this.name,
    this.username,
    required this.tripCount,
    required this.totalDist,
    required this.credits,
  });

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      position: json['position'],
      userId: json['userId'],
      name: json['name'] ?? 'N/A',
      username: json['username'] ?? 'N/A',
      tripCount: json['tripCount'],
      totalDist: json['totalDist'].toDouble(),
      credits: json['credits'].toDouble(),
    );
  }
}
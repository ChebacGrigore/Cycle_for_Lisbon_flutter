import 'dart:convert';

class Acheivement {
  final String userId;
  final String achievementCode;
  final Achievement achievement;
  final int completion;
  final bool achieved;

  Acheivement({
    required this.userId,
    required this.achievementCode,
    required this.achievement,
    required this.completion,
    required this.achieved,
  });

  factory Acheivement.fromRawJson(String str) =>
      Acheivement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Acheivement.fromJson(Map<String, dynamic> json) => Acheivement(
        userId: json["userID"],
        achievementCode: json["achievementCode"],
        achievement: Achievement.fromJson(json["achievement"]),
        completion: json["completion"],
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
  final String image;
  final String name;
  final String desc;

  Achievement({
    required this.code,
    required this.image,
    required this.name,
    required this.desc,
  });

  factory Achievement.fromRawJson(String str) =>
      Achievement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
        code: json["code"],
        image: json["image"],
        name: json["name"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "image": image,
        "name": name,
        "desc": desc,
      };
}

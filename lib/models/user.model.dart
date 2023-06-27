import 'dart:convert';

class Token {
  final String accessToken;
  final String refreshToken;

  Token({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Token.fromRawJson(String str) => Token.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class User {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? username;
  final String name;
  final String subject;
  final String email;
  final bool verified;
  final int? tripCount;
  final double? totalDist;
  final double? credits;

  User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.updatedAt,
    required this.username,
    required this.subject,
    required this.email,
    required this.verified,
    this.credits,
    this.tripCount,
    this.totalDist,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      name: json['name'],
      username: json['username'] ?? 'N/A',
      subject: json['subject'],
      email: json['email'],
      verified: json['verified'],
      tripCount: int.parse(json['tripCount'].toString()),
      totalDist: json['totalDist'].toDouble() ?? 0.0,
      credits: json['credits'].toDouble() ?? 0.0,
    );
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "name": name,
    "username": username,
    "subject": subject,
    "email": email,
    "verified": verified,
    "tripCount": tripCount,
    "totalDist": totalDist,
    "credits": credits,
  };
}

// class UserProfile {
//   final String id;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String name;
//   final String? username;
//   final DateTime birthday;
//   final String gender;
//   final String profilePic;
//   final String subject;
//   final String email;
//   final bool verified;

//   UserProfile({
//     required this.id,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.name,
//     this.username,
//     required this.birthday,
//     required this.gender,
//     required this.profilePic,
//     required this.subject,
//     required this.email,
//     required this.verified,
//   });

//   factory UserProfile.fromJson(Map<String, dynamic> json) {
//     final username = json['username'] as String?;
//     return UserProfile(
//       id: json['id'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       name: json['name'] ?? 'Unknown',
//       username: username ?? 'Unknown',
//       birthday: DateTime.parse(json['birthday']),
//       gender: json['gender'] ?? 'Unknown',
//       profilePic: json['profilepic'],
//       subject: json['subject'],
//       email: json['email'],
//       verified: json['verified'],
//     );
//   }
// }

class UserUpdate {
  final String birthday;
  final String email;
  final String gender;
  final String name;
  final String profilePic;
  final String? username;

  UserUpdate({
    required this.birthday,
    required this.email,
    required this.gender,
    required this.name,
    required this.profilePic,
    this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'birthday': birthday,
      'email': email,
      'gender': gender,
      'name': name,
      'profilepic': profilePic,
      'username': username ?? '',
    };
  }
}

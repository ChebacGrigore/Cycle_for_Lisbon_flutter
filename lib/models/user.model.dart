import 'dart:convert';

import 'initiative.model.dart';

class UserBasic {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String username;
  final String gender;
  final DateTime birthday;
  final String subject;
  final String email;
  final bool verified;
  final int tripCount;
  final double totalDist;
  final double credits;

  UserBasic({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.username,
    required this.gender,
    required this.birthday,
    required this.subject,
    required this.email,
    required this.verified,
    required this.tripCount,
    required this.totalDist,
    required this.credits,
  });

  factory UserBasic.fromRawJson(String str) => UserBasic.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserBasic.fromJson(Map<String, dynamic> json) => UserBasic(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    name: json["name"],
    username: json["username"],
    gender: json["gender"],
    birthday: DateTime.parse(json["birthday"]),
    subject: json["subject"],
    email: json["email"],
    verified: json["verified"],
    tripCount: json["tripCount"],
    totalDist: json["totalDist"]?.toDouble(),
    credits: json["credits"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "name": name,
    "username": username,
    "gender": gender,
    "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
    "subject": subject,
    "email": email,
    "verified": verified,
    "tripCount": tripCount,
    "totalDist": totalDist,
    "credits": credits,
  };
}


// // class User {
// //   final String id;
// //   final DateTime createdAt;
// //   final DateTime updatedAt;
// //   final String? username;
// //   final String name;
// //   final String subject;
// //   final String email;
// //   final bool verified;
// //   final int? tripCount;
// //   final double? totalDist;
// //   final double? credits;
// //
// //   User({
// //     required this.id,
// //     required this.createdAt,
// //     required this.name,
// //     required this.updatedAt,
// //     required this.username,
// //     required this.subject,
// //     required this.email,
// //     required this.verified,
// //     this.credits,
// //     this.tripCount,
// //     this.totalDist,
// //   });
// //
// //   factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
// //
// //   String toRawJson() => json.encode(toJson());
// //   factory User.fromJson(Map<String, dynamic> json) {
// //     return User(
// //       id: json['id'],
// //       createdAt: DateTime.parse(json['createdAt']),
// //       updatedAt: DateTime.parse(json['updatedAt']),
// //       name: json['name'],
// //       username: json['username'] ?? 'N/A',
// //       subject: json['subject'],
// //       email: json['email'],
// //       verified: json['verified'],
// //       tripCount: int.parse(json['tripCount'].toString()),
// //       totalDist: json['totalDist'].toDouble() ?? 0.0,
// //       credits: json['credits'].toDouble() ?? 0.0,
// //     );
// //   }
// //   Map<String, dynamic> toJson() => {
// //     "id": id,
// //     "createdAt": createdAt.toIso8601String(),
// //     "updatedAt": updatedAt.toIso8601String(),
// //     "name": name,
// //     "username": username,
// //     "subject": subject,
// //     "email": email,
// //     "verified": verified,
// //     "tripCount": tripCount,
// //     "totalDist": totalDist,
// //     "credits": credits,
// //   };
// // }
//
// class User {
//   final String id;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String name;
//   final String? username;
//   final DateTime birthday;
//   final String gender;
//   final String? initiativeId;
//   final String subject;
//   final String email;
//   final bool verified;
//
//   User({
//     required this.id,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.name,
//     this.username,
//     required this.birthday,
//     required this.gender,
//     this.initiativeId,
//     required this.subject,
//     required this.email,
//     required this.verified,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     final username = json['username'] as String?;
//     return User(
//       id: json['id'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       name: json['name'],
//       username: username,
//       birthday: DateTime.parse(json['birthday']),
//       gender: json['gender'] ?? 'Unknown',
//       profilePic: json['profilepic'],
//       subject: json['subject'],
//       email: json['email'],
//       verified: json['verified'],
//     );
//   }
// }
//
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

class User {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String username;
  final String gender;
  final String birthday;
  final String subject;
  final String email;
  final bool verified;
  final int tripCount;
  final double totalDist;
  final double credits;
  final String? initiativeId;
  final Initiative? initiative;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.username,
    required this.gender,
    required this.birthday,
    required this.subject,
    required this.email,
    required this.verified,
    required this.tripCount,
    required this.totalDist,
    required this.credits,
     this.initiativeId,
    this.initiative,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    name: json["name"],
    username: json["username"],
    gender: json["gender"],
    birthday: json["birthday"],
    subject: json["subject"],
    email: json["email"],
    verified: json["verified"],
    tripCount: json["tripCount"],
    totalDist: json["totalDist"]?.toDouble(),
    credits: json["credits"]?.toDouble(),
    initiativeId: json["initiativeId"],
    initiative: Initiative.fromJson(json["initiative"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "name": name,
    "username": username,
    "gender": gender,
    "birthday": birthday,
    "subject": subject,
    "email": email,
    "verified": verified,
    "tripCount": tripCount,
    "totalDist": totalDist,
    "credits": credits,
    "initiativeId": initiativeId,
    "initiative": initiative,
  };
}

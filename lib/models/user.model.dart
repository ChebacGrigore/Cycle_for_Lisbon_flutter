class User {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? username;
  final String subject;
  final String email;
  final bool verified;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.username,
    required this.subject,
    required this.email,
    required this.verified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      username: json['username'] ?? '',
      subject: json['subject'],
      email: json['email'],
      verified: json['verified'],
    );
  }
}

class UserUpdate {
  final String birthday;
  final String email;
  final String gender;
  final String name;
  final String profilePic;
  final String username;

  UserUpdate({
    required this.birthday,
    required this.email,
    required this.gender,
    required this.name,
    required this.profilePic,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'birthday': birthday,
      'email': email,
      'gender': gender,
      'name': name,
      'profilepic': profilePic,
      'username': username,
    };
  }
}

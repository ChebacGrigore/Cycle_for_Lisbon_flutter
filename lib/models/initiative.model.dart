import 'dart:convert';

class Initiative {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String description;
  final DateTime endDate;
  final int goal;
  final double credits;
  final bool enabled;
  final String institutionId;
  final List<Sdg>? sdgs;
  final List<Sponsor>? sponsors;
  final String? presignedImageUrl;
  final Institution institution;

  Initiative({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.description,
    required this.endDate,
    required this.goal,
    required this.credits,
    required this.enabled,
    required this.institutionId,
    this.sdgs = const [],
    this.sponsors = const [],
    required this.presignedImageUrl,
    required this.institution,
  });

  factory Initiative.fromRawJson(String str) =>
      Initiative.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Initiative.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? sdgsJson = json['sdgs'];
    final List<dynamic>? sponsorJson = json['sponsors'];

    List<Sdg> sdgs = [];
    List<Sponsor> sponsor = [];
    if (sdgsJson != null) {
      sdgs = sdgsJson.map((sdgJson) => Sdg.fromJson(sdgJson)).toList();
    }
    if (sponsorJson != null) {
      sponsor = sponsorJson.map((sdgJson) => Sponsor.fromJson(sdgJson)).toList();
    }
    return Initiative(
      id: json["id"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      title: json["title"],
      description: json["description"],
      endDate: DateTime.parse(json["endDate"]),
      goal: json["goal"],
      credits: json["credits"]?.toDouble(),
      enabled: json["enabled"],
      institutionId: json["institutionId"],
      sdgs: sdgs,
      sponsors: sponsor,
      presignedImageUrl: json["presignedImageURL"] ?? '',
      institution: Institution.fromJson(json["institution"]),
    );

  }
  Map<String, dynamic> toJson() {
    final data = {
      "id": id,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "title": title,
      "description": description,
      "endDate":
          "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      "goal": goal,
      "credits": credits,
      "enabled": enabled,
      "institutionId": institutionId,
      // "sdgs": List<dynamic>.from(sdgs != null ? sdgs.map((x) => x.toJson())),
      "presignedImageURL": presignedImageUrl,
      "institution": institution.toJson()
    };
    if (sdgs != null) {
      data['sdgs'] = sdgs!.map((sdg) => sdg.toJson()).toList();
    } else {
      data['sdgs'] = [];
    }
    if (sponsors != null) {
      data['sponsors'] = sponsors!.map((spons) => spons.toJson()).toList();
    } else {
      data['sponsors'] = [];
    }
    return data;
  }
}

class Institution {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String description;
  final String? presignedLogoUrl;

  Institution({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
    required this.presignedLogoUrl,
  });

  factory Institution.fromRawJson(String str) =>
      Institution.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Institution.fromJson(Map<String, dynamic> json) => Institution(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        name: json["name"],
        description: json["description"],
        presignedLogoUrl: json["presignedLogoURL"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "name": name,
        "description": description,
        "presignedLogoURL": presignedLogoUrl,
      };
}

class Sdg {
  final int code;
  final String title;
  final String description;
  final String imageUri;

  Sdg({
    required this.code,
    required this.title,
    required this.description,
    required this.imageUri,
  });

  factory Sdg.fromRawJson(String str) => Sdg.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sdg.fromJson(Map<String, dynamic> json) => Sdg(
        code: json["code"],
        title: json["title"],
        description: json["description"],
        imageUri: json["imageURI"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "description": description,
        "imageURI": imageUri,
      };
}

class Sponsor {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String description;
  final String presignedLogoUrl;

  Sponsor({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
    required this.presignedLogoUrl,
  });

  factory Sponsor.fromRawJson(String str) => Sponsor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sponsor.fromJson(Map<String, dynamic> json) => Sponsor(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    name: json["name"],
    description: json["description"],
    presignedLogoUrl: json["presignedLogoURL"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "name": name,
    "description": description,
    "presignedLogoURL": presignedLogoUrl,
  };
}


class EventModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String type;
  final String state;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String articleUrl;
  final String subject;
  final String description;
  final String period;
  final String languageCode;
  final Language language;

  EventModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.state,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.articleUrl,
    required this.subject,
    required this.description,
    required this.period,
    required this.languageCode,
    required this.language,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      type: json['type'],
      state: json['state'],
      title: json['title'],
      subtitle: json['subtitle'],
      imageUrl: json['imageUrl'],
      articleUrl: json['articleUrl'],
      subject: json['subject'],
      description: json['description'],
      period: json['period'],
      languageCode: json['languageCode'],
      language: Language.fromJson(json['language']),
    );
  }
}

class NewsModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String type;
  final String state;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String articleUrl;
  final String subject;
  final DateTime date;
  final String languageCode;
  final Language language;

  NewsModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.state,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.articleUrl,
    required this.subject,
    required this.date,
    required this.languageCode,
    required this.language,
  });

  factory NewsModel.fromRawJson(String str) =>
      NewsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        type: json["type"],
        state: json["state"],
        title: json["title"],
        subtitle: json["subtitle"],
        imageUrl: json["imageUrl"],
        articleUrl: json["articleUrl"],
        subject: json["subject"],
        date: DateTime.parse(json["date"]),
        languageCode: json["languageCode"],
        language: Language.fromJson(json["language"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "type": type,
        "state": state,
        "title": title,
        "subtitle": subtitle,
        "imageUrl": imageUrl,
        "articleUrl": articleUrl,
        "subject": subject,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "languageCode": languageCode,
        "language": language.toJson(),
      };
}

class Language {
  final String code;
  final String name;
  final String nativeName;

  Language({
    required this.code,
    required this.name,
    required this.nativeName,
  });

  factory Language.fromRawJson(String str) =>
      Language.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        code: json["code"],
        name: json["name"],
        nativeName: json["nativeName"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "nativeName": nativeName,
      };
}

class Initiative {
  final String createdAt;
  final String description;
  final bool enabled;
  final String endDate;
  final int goal;
  final String id;
  final String title;
  final String updatedAt;

  Initiative({
    required this.createdAt,
    required this.description,
    required this.enabled,
    required this.endDate,
    required this.goal,
    required this.id,
    required this.title,
    required this.updatedAt,
  });

  factory Initiative.fromJson(Map<String, dynamic> json) {
    return Initiative(
      createdAt: json['createdAt'],
      description: json['description'],
      enabled: json['enabled'],
      endDate: json['endDate'],
      goal: json['goal'],
      id: json['id'],
      title: json['title'],
      updatedAt: json['updatedAt'],
    );
  }
}

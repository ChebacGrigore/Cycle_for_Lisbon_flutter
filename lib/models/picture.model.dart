class Picture {
  final String url;
  final String method;

  Picture({
    required this.url,
    required this.method,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      url: json['url'],
      method: json['method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'method': method,
    };
  }
}

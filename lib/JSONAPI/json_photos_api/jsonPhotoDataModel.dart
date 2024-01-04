class Photos {
  final int albumId;
  final int id;
  final String title;
  final String? url;
  final String? thumbnailUrl;

  Photos({
    required this.albumId,
    required this.id,
    required this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      albumId: json['albumId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      url: json['url'], // Add url property
      thumbnailUrl: json['thumbnailUrl'], // Add thumbnailUrl property
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
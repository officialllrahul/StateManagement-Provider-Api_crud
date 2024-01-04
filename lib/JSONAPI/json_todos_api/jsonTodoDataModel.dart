

class Todos {
  final int? userId;
  final int id;
  final String title;
  final bool? completed;

  Todos({
    this.userId,
    required this.id,
    required this.title,
    this.completed
  });

  factory Todos.fromJson(Map<String, dynamic> json) {
    return Todos(
      userId: json['userId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      completed:  json['completed'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed
    };
  }
}
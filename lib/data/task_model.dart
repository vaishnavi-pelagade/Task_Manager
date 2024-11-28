class Task {
  final int? id;
  final String title;
  final String description;
  final String dueDate;
  final String status;
  final bool isCompleted;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    this.isCompleted = false,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['dueDate'],
      status: map['status'],
      isCompleted:
          map['isCompleted'] ?? false, // Ensure default value if not present
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'status': status,
      'isCompleted': isCompleted,
    };
  }

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: json['dueDate'],
      status: json['status'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'status': status,
      'isCompleted': isCompleted,
    };
  }
}

class Task {
  final String id; // UUID dari Supabase
  final String title;
  final String description;
  final DateTime deadline;
  final bool isDone;
  final String priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.isDone,
    required this.priority,
  });

  /// =====================
  /// FROM SUPABASE MAP
  /// =====================
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      deadline: DateTime.parse(map['deadline']),
      isDone: map['is_done'] ?? false,
      priority: map['priority'] ?? 'Sedang',
    );
  }

  /// =====================
  /// MAP UNTUK UPDATE / INSERT
  /// (id TIDAK disertakan)
  /// =====================
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
      'is_done': isDone,
      'priority': priority,
    };
  }
}

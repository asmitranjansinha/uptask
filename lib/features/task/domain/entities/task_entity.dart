class TaskEntity {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority; // low, medium, high
  final bool isCompleted;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });
}

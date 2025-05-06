import 'package:uuid/uuid.dart';
import 'task_category.dart';

class Task {
  final String id;
  String title;
  String description;
  DateTime dueDate;
  bool isCompleted;
  TaskCategory category;

  Task({
    String? id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    required this.category,
  }) : id = id ?? const Uuid().v4();

  // Create a copy of the task with updated fields
  Task copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
    TaskCategory? category,
  }) {
    return Task(
      id: this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
    );
  }

  // Check if the task is due soon (within the next 24 hours)
  bool get isDueSoon {
    final now = DateTime.now();
    final difference = dueDate.difference(now);
    return !isCompleted && difference.inHours <= 24 && difference.isNegative == false;
  }

  // Check if the task is overdue
  bool get isOverdue {
    final now = DateTime.now();
    return !isCompleted && dueDate.isBefore(now);
  }
}
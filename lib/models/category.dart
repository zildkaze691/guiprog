import 'package:flutter/material.dart';
import '../config/theme.dart';

// Enum to represent task categories
enum TaskCategory {
  academic,
  personal,
  work,
}

// Extension to add properties to the enum
extension TaskCategoryExtension on TaskCategory {
  String get name {
    switch (this) {
      case TaskCategory.academic:
        return 'Academic';
      case TaskCategory.personal:
        return 'Personal';
      case TaskCategory.work:
        return 'Work';
    }
  }

  IconData get icon {
    switch (this) {
      case TaskCategory.academic:
        return Icons.school;
      case TaskCategory.personal:
        return Icons.person;
      case TaskCategory.work:
        return Icons.work;
    }
  }

  Color get color {
    switch (this) {
      case TaskCategory.academic:
        return AppTheme.primaryBlue;
      case TaskCategory.personal:
        return Colors.green;
      case TaskCategory.work:
        return Colors.purple;
    }
  }

  // Get all category values as a List
  static List<TaskCategory> get values => [
        TaskCategory.academic,
        TaskCategory.personal,
        TaskCategory.work,
      ];
}
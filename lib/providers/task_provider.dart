import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../models/task_category.dart';

class TaskProvider with ChangeNotifier {
  // In-memory storage for tasks
  final List<Task> _tasks = [];
  String _searchQuery = '';
  TaskCategory? _selectedCategory;

  // Getters
  List<Task> get tasks => _tasks;
  String get searchQuery => _searchQuery;
  TaskCategory? get selectedCategory => _selectedCategory;

  // Filtered tasks based on search query and selected category
  List<Task> get filteredTasks {
    return _tasks.where((task) {
      // Filter by search query
      final matchesQuery = _searchQuery.isEmpty ||
          task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          task.description.toLowerCase().contains(_searchQuery.toLowerCase());

      // Filter by category
      final matchesCategory = _selectedCategory == null || task.category == _selectedCategory;

      return matchesQuery && matchesCategory;
    }).toList();
  }

  // Add a new task
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  // Update an existing task
  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  // Delete a task
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  // Toggle task completion status
  void toggleTaskCompletion(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      final task = _tasks[index];
      _tasks[index] = task.copyWith(isCompleted: !task.isCompleted);
      notifyListeners();
    }
  }

  // Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Set selected category filter
  void setSelectedCategory(TaskCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Add sample tasks (for testing)
  void addSampleTasks() {
    final now = DateTime.now();
    
    _tasks.addAll([
      Task(
        title: 'Complete Flutter Assignment',
        description: 'Finish the TO-DO app project for Mobile Development class',
        dueDate: now.add(const Duration(days: 3)),
        category: TaskCategory.academic,
      ),
      Task(
        title: 'Study for Database Exam',
        description: 'Review SQL queries and normalization',
        dueDate: now.add(const Duration(days: 1)),
        category: TaskCategory.academic,
      ),
      Task(
        title: 'Grocery Shopping',
        description: 'Buy fruits, vegetables, and other essentials',
        dueDate: now.add(const Duration(hours: 6)),
        category: TaskCategory.personal,
      ),
      Task(
        title: 'Team Meeting',
        description: 'Discuss project progress with team members',
        dueDate: now.add(const Duration(days: 2)),
        category: TaskCategory.work,
      ),
    ]);
    
    notifyListeners();
  }
}
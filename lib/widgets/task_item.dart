import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/task_form_screen.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine card color based on task status
    Color cardColor = Colors.white;
    if (task.isOverdue) {
      cardColor = Colors.red.shade50;
    } else if (task.isDueSoon) {
      cardColor = Colors.amber.shade50;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToEditScreen(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task header
              Row(
                children: [
                  // Category icon
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: task.category.color.withOpacity(0.2),
                    child: Icon(
                      task.category.icon,
                      size: 18,
                      color: task.category.color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Task title
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                        color: task.isCompleted ? AppTheme.textLight : AppTheme.textDark,
                      ),
                    ),
                  ),
                  
                  // Task completion checkbox
                  Checkbox(
                    value: task.isCompleted,
                    activeColor: AppTheme.primaryBlue,
                    onChanged: (value) {
                      Provider.of<TaskProvider>(context, listen: false)
                          .toggleTaskCompletion(task.id);
                    },
                  ),
                ],
              ),
              
              // Task description
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text(
                  task.description,
                  style: TextStyle(
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    color: task.isCompleted ? AppTheme.textLight : null,
                  ),
                ),
              ),
              
              // Task footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Due date info
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: _getDueDateColor(),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('MMM dd, h:mm a').format(task.dueDate),
                        style: TextStyle(
                          fontSize: 12,
                          color: _getDueDateColor(),
                          fontWeight: task.isDueSoon || task.isOverdue
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  
                  // Action buttons
                  Row(
                    children: [
                      // Edit button
                      IconButton(
                        icon: const Icon(Icons.edit, size: 18),
                        color: AppTheme.primaryBlue,
                        onPressed: () => _navigateToEditScreen(context),
                      ),
                      
                      // Delete button
                      IconButton(
                        icon: const Icon(Icons.delete, size: 18),
                        color: AppTheme.warningRed,
                        onPressed: () => _showDeleteConfirmation(context),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Get color based on due date status
  Color _getDueDateColor() {
    if (task.isOverdue) {
      return AppTheme.warningRed;
    } else if (task.isDueSoon) {
      return Colors.amber.shade800;
    }
    return AppTheme.textLight;
  }

  // Navigate to edit task screen
  void _navigateToEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskFormScreen(task: task),
      ),
    );
  }

  // Show delete confirmation dialog
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: const Text(
              'Delete',
              style: TextStyle(color: AppTheme.warningRed),
            ),
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}
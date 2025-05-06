import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_category.dart';
import '../providers/task_provider.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // All categories filter option
              FilterChip(
                label: const Row(
                  children: [
                    Icon(Icons.filter_list, size: 16),
                    SizedBox(width: 4),
                    Text('All'),
                  ],
                ),
                selected: provider.selectedCategory == null,
                onSelected: (selected) {
                  if (selected) {
                    provider.setSelectedCategory(null);
                  }
                },
              ),
              const SizedBox(width: 8),
              
              // Individual category filter options
              ...TaskCategory.values.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    avatar: CircleAvatar(
                      backgroundColor: category.color,
                      child: Icon(
                        category.icon,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                    label: Text(category.name),
                    selected: provider.selectedCategory == category,
                    onSelected: (selected) {
                      provider.setSelectedCategory(selected ? category : null);
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
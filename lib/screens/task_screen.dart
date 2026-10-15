import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<Task> tasks = [
    Task(title: 'Revise Dart OOP'),
    Task(title: 'Practice Flutter widgets'),
    Task(title: 'Build Task Manager'),
    Task(title: 'Prepare for Radixweb'),
  ];

  final TextEditingController taskController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  String searchQuery = '';
  String selectedFilter = 'All';

  @override
  void dispose() {
    taskController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = tasks.where((task) {
      final matchesSearch =
          task.title.toLowerCase().contains(searchQuery);

      final matchesFilter = selectedFilter == 'All' ||
          (selectedFilter == 'Pending' && !task.isCompleted) ||
          (selectedFilter == 'Completed' && task.isCompleted);

      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      labelText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => addTask(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.trim().toLowerCase();
                });
              },
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: ['All', 'Pending', 'Completed'].map((filter) {
                final isSelected = selectedFilter == filter;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected ? Colors.blue : Colors.grey.shade300,
                        foregroundColor:
                            isSelected ? Colors.white : Colors.black,
                      ),
                      child: Text(filter),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filteredTasks.isEmpty
                ? Center(
                    child: Text(
                      tasks.isEmpty
                          ? 'No tasks yet. Add a task to get started.'
                          : 'No matching tasks found.',
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];

                      return ListTile(
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) {
                            if (value != null) {
                              toggleTask(task, value);
                            }
                          },
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            color: task.isCompleted ? Colors.grey : null,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: IconButton(
                          tooltip: 'Delete task',
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteTask(task),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void toggleTask(Task task, bool isCompleted) {
    setState(() {
      task.isCompleted = isCompleted;
    });
  }

  void deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  void addTask() {
    final title = taskController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    setState(() {
      tasks.add(Task(title: title));
      searchQuery = '';
      searchController.clear();
    });

    taskController.clear();
  }
}

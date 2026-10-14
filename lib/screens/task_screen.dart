import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [
    Task(title: 'Revise Dart OOP'),
    Task(title: 'Practice Flutter widgets'),
    Task(title: 'Build Task Manager'),
    Task(title: 'Prepare for Radixweb'),
  ];

  final TextEditingController taskController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = tasks.where((task) {
      return task.title.toLowerCase().contains(searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('My Tasks'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchQuery = val.trim().toLowerCase();
                      });
                    },
                    onSubmitted: (_) => addTask(),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(onPressed: addTask, child: Text('Add')),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (filteredTasks.isEmpty) {
                  return const Center(child: Text('No tasks found'));
                }

                return ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];

                    return ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          toggleTask(tasks.indexOf(task), value!);
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
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void toggleTask(int index, bool value) {
    setState(() {
      tasks[index].isCompleted = value;
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
    });

    taskController.clear();
  }

  void searchTask() {}
}

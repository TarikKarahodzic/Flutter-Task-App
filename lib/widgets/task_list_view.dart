import 'package:flutter/material.dart';
import 'package:flutter_test1/models/task.dart';
import 'package:flutter_test1/screens/add_task_page.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final List<Task> tasks = [
    Task(title: 'Task 1', status: TaskStatus.pending),
    Task(title: 'Task 2', status: TaskStatus.completed),
    Task(title: 'Task 3', status: TaskStatus.pending),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskPage()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            leading: task.status == TaskStatus.completed
                ? const Icon(Icons.check_box)
                : const Icon(Icons.check_box_outline_blank),
            onTap: () {
              setState(() {
                final isCompleted = task.status == TaskStatus.completed;
                tasks[index] = Task(
                  title: task.title,
                  status: isCompleted
                      ? TaskStatus.pending
                      : TaskStatus.completed,
                );
              });
            },
          );
        },
      ),
    );
  }
}

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
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskPage()),
          );

          if (result == null) return;

          final title = (result as String).trim();
          if (title.isEmpty) return;

          setState(() {
            tasks.add(Task(title: title, status: TaskStatus.pending));
          });
        },
        child: const Icon(Icons.add),
      ),

      body: tasks.isEmpty
          ? const Center(child: Text('No tasks available.'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  key: ValueKey(task.title),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    final removedTask = task;
                    final removedIndex = index;

                    setState(() {
                      tasks.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).clearSnackBars();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text('Deleted "${removedTask.title}"'),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            setState(() {
                              tasks.insert(removedIndex, removedTask);
                            });
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                  },
                  child: ListTile(
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
                  ),
                );
              },
            ),
    );
  }
}

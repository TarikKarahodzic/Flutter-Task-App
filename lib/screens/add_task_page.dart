import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _controller.text);
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}

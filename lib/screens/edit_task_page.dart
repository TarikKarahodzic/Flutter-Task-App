import 'package:flutter/material.dart';
import 'package:flutter_test1/models/task.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key, required this.task});

  final Task task;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.task.title,
  );

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Task')),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
                controller: _controller,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  final trimmed = _controller.text.trim();
                  Navigator.pop(
                    context,
                    Task(title: trimmed, status: widget.task.status),
                  );
                },
                child: const Text('Edit Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

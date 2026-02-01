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

  late final String _originalTitle;
  bool _canSave = false;
  bool get _isDirty => _controller.text.trim() != _originalTitle;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _originalTitle = widget.task.title.trim();

    _controller.addListener(() {
      final current = _controller.text.trim();
      final nextCanSave = current.isNotEmpty && current != _originalTitle;

      if (nextCanSave != _canSave) {
        setState(() {
          _canSave = nextCanSave;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_isDirty) return true;

        final shouldDiscard = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Discard changes?'),
            content: const Text('You have unsaved changes. Discard them?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Discard'),
              ),
            ],
          ),
        );

        return shouldDiscard ?? false;
      },

      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Task')),
        body: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(6),
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: _controller,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a task title';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _canSave
                      ? () {
                          if (!_formKey.currentState!.validate()) return;

                          final trimmed = _controller.text.trim();
                          Navigator.pop(
                            context,
                            Task(id: widget.task.id, title: trimmed, status: widget.task.status),
                          );
                        }
                      : null,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

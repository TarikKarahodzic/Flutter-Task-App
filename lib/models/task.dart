enum TaskStatus { pending, completed }

class Task { 
  final String id;
  final String title;
  final TaskStatus status;

  Task({required this.id, required this.title, required this.status});
}

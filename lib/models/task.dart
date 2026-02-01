enum TaskStatus { pending, completed }

class Task {
  final String title;
  final TaskStatus status;

  const Task({required this.title, required this.status});
}

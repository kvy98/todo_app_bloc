enum Status { isDoing, isPending, isDone }

class Task {
  final String id;
  final String title;
  final DateTime createAt;
  final Status status;
  Task({
    this.createAt,
    this.id,
    this.status,
    this.title,
  });
}

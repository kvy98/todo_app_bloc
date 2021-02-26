import 'package:todo_list/models/task.dart';

abstract class TaskEvent {}

class AddTaskEvent implements TaskEvent {
  final String title;
  AddTaskEvent(this.title);
}

class RemoveTask implements TaskEvent {
  final String id;
  RemoveTask(this.id);
}

class UpdateTask implements TaskEvent {
  final Task task;
  UpdateTask(this.task);
}

import 'dart:async';

import 'package:todo_list/blocs/task_state.dart';
import 'package:todo_list/blocs/task_event.dart';
import 'package:todo_list/models/task.dart';

class TaskBloc {
  TasksState _state = TasksState([]);
  StreamController<TaskEvent> taskEventController = StreamController();
  StreamController<TasksState> taskStateController = StreamController();
  TasksState get state => TasksState([..._state.items]);
  TaskBloc() {
    taskEventController.stream.listen((event) {
      final tasksState = TasksState([...this._state.items]);
      if (event is AddTaskEvent) {
        final Task task = Task(
            id: DateTime.now().hashCode.toString(),
            createAt: DateTime.now(),
            status: Status.isDoing,
            title: event.title);
        tasksState.items.add(task);
        taskStateController.sink.add(tasksState);
      } else if (event is RemoveTask) {
        print(event.id);
        tasksState.items.removeWhere((element) => element.id == event.id);
        taskStateController.sink.add(tasksState);
      } else if (event is UpdateTask) {
        int index = tasksState.items
            .indexWhere((element) => element.id == event.task.id);
        if (index != -1) {
          tasksState.items[index] = event.task;
          taskStateController.sink.add(tasksState);
        }
      } else
        return;
      _state = tasksState;
    });
  }
}

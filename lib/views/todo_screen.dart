import 'package:flutter/material.dart';
import 'package:todo_list/blocs/task_bloc.dart';
import 'package:todo_list/blocs/task_event.dart';
import 'package:todo_list/blocs/task_state.dart';
import 'package:todo_list/models/task.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TaskBloc bloc = TaskBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoApp'),
      ),
      body: StreamBuilder(
        builder: (context, AsyncSnapshot<TasksState> snapshot) {
          if (snapshot.hasData) {
            List<Task> tasks = snapshot.data.items;
            return ListView.builder(
              itemBuilder: (_, index) => ListTile(
                  title: Text(tasks[index].title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FlatButton.icon(
                          onPressed: () {
                            bloc.taskEventController.sink
                                .add(RemoveTask(tasks[index].id));
                          },
                          icon: Icon(Icons.delete),
                          label: Text('delete')),
                      FlatButton.icon(
                          onPressed: () {
                            bloc.taskEventController.sink.add(UpdateTask(Task(
                                id: tasks[index].id, title: 'update test')));
                          },
                          icon: Icon(Icons.update),
                          label: Text('update'))
                    ],
                  )),
              itemCount: tasks.length,
            );
          }
          return Center(child: Text('Empty'));
        },
        // initialData: bloc.state,
        stream: bloc.taskStateController.stream,
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.add),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Add Task',
                      style: TextStyle(fontSize: 40),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'task name'),
                    ),
                    Row(
                      children: [
                        Text(DateTime.now().toString()),
                        FlatButton(onPressed: null, child: Text('choose date'))
                      ],
                    ),
                    RaisedButton(
                      onPressed: () {
                        bloc.taskEventController.sink.add(AddTaskEvent('test'));
                      },
                      child: Text('submit'),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

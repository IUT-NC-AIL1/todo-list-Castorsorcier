import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/screens/task_form.dart';
import 'package:todo_list/screens/tasks_master.dart';

class ToDoListApp extends StatefulWidget {
  const ToDoListApp({Key? key}) : super(key: key);

  @override
  State<ToDoListApp> createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('ToDo List'),
              ),
              body: const TasksMaster(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(
                        builder: (context) => TaskForm(task: Task(content: 'Contenu', completed: false),)),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }
}

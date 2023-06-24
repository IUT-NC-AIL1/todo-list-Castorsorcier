import 'package:flutter/material.dart';
import 'package:todo_list/providers/tasks_provider.dart';
import 'package:todo_list/screens/tasks_master.dart';
import 'package:todo_list/todo_list_app.dart';

import '../models/task.dart';

class TaskForm extends StatefulWidget {
  Task? task=Task(content: '', completed: false);
  TaskForm({this.task, Key? key}) : super(key: key);

  @override
  State<TaskForm> createState() => _TaskForm();
}

class _TaskForm extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              builder: (context) =>
                  Center(
                      child:Scaffold(
                          appBar: AppBar(
                            title: const Text('ToDo List'),
                          ),
                          body: Center(
                            child: Form(
                                key: _formKey,
                                child: Container(
                                  //width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(12),
                                  child: Card(
                                    elevation: 5,
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      child: Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        direction: Axis.vertical,
                                        spacing: 12,
                                        children: [
                                          const Text('Ajouter une nouvelle tâche'),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 3 * 2,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  helperText: 'Titre',
                                                  labelStyle:
                                                  TextStyle(fontWeight: FontWeight.bold)),
                                              validator: (String? value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Insérez un titre';
                                                }
                                                return null;
                                              },
                                              onChanged: (value){
                                                setState(() {
                                                  widget.task!.title=value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 3 * 2,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                helperText: 'Contenu',
                                              ),
                                              validator: (String? value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Insérez un contenu';
                                                }
                                                return null;
                                              },
                                              onChanged: (value){
                                                setState(() {
                                                  widget.task!.content=value;
                                                });
                                              },
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!.validate())  {

                                                await TasksProvider().addTask(widget.task!);
                                                Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) =>
                                                    const ToDoListApp()));
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'La tâche a été ajoutée',
                                                      style: TextStyle(fontSize: 16.0),
                                                    ),
                                                    backgroundColor: Colors.orange,
                                                  ),
                                                );
                                              }
                                            },
                                            child: const Icon(
                                              Icons.save,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ))
                  )
          );
        }
    );
  }
}

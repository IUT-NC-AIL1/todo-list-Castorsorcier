import 'package:flutter/material.dart';
import 'package:todo_list/providers/tasks_provider.dart';

import '../models/task.dart';
import '../todo_list_app.dart';

class TasksDetails extends StatefulWidget {
  final Task? task;

  const TasksDetails({Key? key, required this.task}) : super(key: key);

  @override
  State<TasksDetails> createState() => _TasksDetails();
}

class _TasksDetails extends State<TasksDetails> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      body: Form(
          key: _formKey,
          child: Center(
            child: Container(
              //width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(12),
              child: Card(
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    direction: Axis.vertical,
                    spacing: 12,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3 * 2,
                        child: TextFormField(
                          initialValue: widget.task!.title!,
                          decoration: InputDecoration(
                              helperText: 'Titre',
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Insérez un titre';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              widget.task!.title = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3 * 2,
                        child: TextFormField(
                          initialValue: widget.task!.content!,
                          decoration: InputDecoration(
                            helperText: 'Contenu',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Insérez un contenu';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              widget.task!.content = value;
                            });
                          },
                        ),
                      ),
                      FormField(builder: (context) {
                        return Checkbox(
                            value: widget.task!.completed,
                            onChanged: (value) {
                              setState(() {
                                widget.task!.completed = value!;
                              });
                            });
                      }),
                      Wrap(
                        spacing: 20,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await TasksProvider().modifyTask(widget.task!);
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ToDoListApp()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'La tâche a été modifiée',
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
                          ElevatedButton(
                            child: const Icon(
                              Icons.delete,
                            ),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(
                                      'Confirmez-vous la suppression de cette tâche ?'),
                                  actions: [
                                    ColoredBox(
                                        color: Colors.green,
                                        child: TextButton(
                                          child: Text(
                                            'Oui',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            await TasksProvider()
                                                .deleteTask(widget.task!);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ToDoListApp()));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'La tâche a été supprimée',
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                                backgroundColor: Colors.orange,
                                              ),
                                            );
                                          },
                                        )),
                                    ColoredBox(
                                      color: Colors.red,
                                      child: TextButton(
                                          child: Text(
                                            'Non',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

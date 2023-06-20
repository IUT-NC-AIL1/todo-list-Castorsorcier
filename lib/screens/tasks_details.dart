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
                          decoration: InputDecoration(
                              labelText: widget.task!.title!,
                              helperText: 'Titre',
                              labelStyle: const TextStyle(fontWeight: FontWeight.bold)),
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
                          decoration: InputDecoration(
                            labelText: widget.task!.content,
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
                      FormField(builder: (context){
                        return Checkbox(value: widget.task!.completed,
                            onChanged: (value) {
                              setState(() {
                                widget.task!.completed = value!;
                              });
                        });
                      }),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            TasksProvider().modifyTask(widget.task!);
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) =>
                                const ToDoListApp()));
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
            ),
          )),
    );
  }
}

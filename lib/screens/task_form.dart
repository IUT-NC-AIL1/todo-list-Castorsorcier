import 'package:flutter/material.dart';
import 'package:todo_list/screens/tasks_master.dart';

import '../models/task.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  State<TaskForm> createState() => _TaskForm();
}

class _TaskForm extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ToDo List'),
        ),
        body: Navigator(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => Center(
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
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                        const TasksMaster()));
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
              )
            );
          },
        ));
  }
}

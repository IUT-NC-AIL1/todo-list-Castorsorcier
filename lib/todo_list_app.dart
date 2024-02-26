import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/providers/tasks_provider.dart';
import 'package:todo_list/screens/task_form.dart';
import 'package:todo_list/screens/tasks_master.dart';

class ToDoListApp extends StatefulWidget {
  const ToDoListApp({Key? key}) : super(key: key);

  @override
  State<ToDoListApp> createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  bool isListVisible=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Wrap(
          children: [
            Text('test'),
            Text('test')
          ],
        ),
      ),
      bottomNavigationBar:Container(
        margin: EdgeInsets.only(right: MediaQuery.sizeOf(context).width/2.2, left: MediaQuery.sizeOf(context).width/2.2),
        child: SubmenuButton(
            menuStyle: MenuStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(7))
            ),
            menuChildren: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  TextButton(
                      onPressed: ()async{
                        TasksProvider.sortedAttribute='id';
                        await TasksProvider().getTasks();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ToDoListApp()));
                      },
                      child: Text(
                        'Trier par date de création',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      )
                  ),
                  TextButton(
                      onPressed: ()async{
                        TasksProvider.sortedAttribute='completed';
                        await TasksProvider().getTasks();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ToDoListApp()));
                      },
                      child: Text(
                        'Trier par tâche complétée',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      )
                  ),
                  TextButton(
                      onPressed: ()async{
                        TasksProvider.sortedAttribute='title';
                        await TasksProvider().getTasks();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ToDoListApp()));
                      },
                      child: Text(
                        'Trier par titre',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      )
                  ),
                  TextButton(
                      onPressed: ()async{
                        TasksProvider.isInverted=!TasksProvider.isInverted;
                        await TasksProvider().getTasks();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ToDoListApp()));
                      },
                      child: Text(
                        'Inverser l\'ordre de tri',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      )
                  ),
                ],
              )
            ],
            child: ElevatedButton(
                style: ButtonStyle(

                ),
                onPressed: (){

                },
                child: Icon(Icons.sort)
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskForm(
                  task: Task(content: 'Contenu', completed: false),
                )),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
          title: const Text('ToDo List'),
      ),
      body: const TasksMaster(),

    );
  }
}

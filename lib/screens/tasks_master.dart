import 'package:flutter/cupertino.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';

class TasksMaster extends StatefulWidget{
  const TasksMaster({Key? key}) : super(key: key);


  State<TasksMaster> createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster>{

  Future<List<Task>> _fetchTasks() async{
    List<Task> res=[];
    for(int i=0;i<100;i++){
      res.add(Task(
        content: faker.lorem.sentence(),
        completed: random.boolean(),
      ));
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<Task>>(
      future: _fetchTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return TaskPreview(
                task: snapshot.data![index],
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class TaskPreview extends StatelessWidget{
  Task task=Task(content: '', completed: '');
  TaskPreview({Key? key, required task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.content),
      tileColor: task.completed?Color.fromRGBO(0, 255, 0, 1):Color.fromRGBO(255, 0, 0, 1),
    );
  }
}
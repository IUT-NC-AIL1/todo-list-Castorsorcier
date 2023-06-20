import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/screens/tasks_details.dart';

import '../models/task.dart';

class TaskPreview extends StatelessWidget {
  final Task? task;

  const TaskPreview({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ListTile(
      contentPadding: const EdgeInsets.all(5),
      title: Text(
        task?.title ?? '',
        style: const TextStyle(
          fontSize: 18,
          //fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Text(task?.content ?? ''),
      leading: task!.completed
          ? Icon(
              Icons.check,
              color: Colors.green,
            )
          : Icon(
              Icons.warning,
              color: Colors.red,
            ),
      hoverColor: task!.completed
          ? const Color.fromRGBO(105, 240, 174, 1.0)
          : const Color.fromRGBO(255, 82, 82, 1.0),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => TasksDetails(task: task)));
      },
    );
  }
}

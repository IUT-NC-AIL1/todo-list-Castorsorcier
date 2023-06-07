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
      leading: Icon(
          task!.completed?Icons.check:Icons.warning
      ),
      hoverColor: task!.completed
          ? const Color.fromRGBO(67, 180, 67, 0.8)
          : const Color.fromRGBO(227, 54, 54, 0.8),
      onTap: ()
      {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => TasksDetails(task: task)
            )
        );
      },
    );
  }
}
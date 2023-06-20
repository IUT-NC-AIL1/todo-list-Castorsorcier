import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/providers/tasks_provider.dart';
import 'package:todo_list/screens/tasks_preview.dart';

import '../models/task.dart';

class TasksMaster extends StatefulWidget {
  const TasksMaster({Key? key}) : super(key: key);

  @override
  State<TasksMaster> createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  void completeTask(task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  // Future<List<Task>> _fetchTasks() async {
  //   List<Task> res = [];
  //   for (int i = 1; i <= 100; i++) {
  //     res.add(Task(
  //       id: i,
  //       content: faker.lorem.sentence(),
  //       completed: random.boolean(),
  //       title: faker.lorem.sentence(),
  //     ));
  //     print('$i, ${res[i-1].content}, ${res[i-1].completed}, ${res[i-1].title}');
  //   }
  //
  //   return TasksProvider.getTasks();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<Task>>(
      future: TasksProvider().getTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return TaskPreview(
                task: snapshot.data![index],
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

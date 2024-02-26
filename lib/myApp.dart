import 'package:flutter/material.dart';
import 'package:todo_list/todo_list_app.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Material App',
      home: ToDoListApp(),
    );
  }
}
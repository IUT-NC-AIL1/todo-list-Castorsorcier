import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> res = [];

  static String sortedAttribute='id';
  static bool isInverted=true;

  Future<List<Task>> getTasks() async {
    final supabase = Supabase.instance.client;
    final response;
    response = await supabase.from("Task").select().order(sortedAttribute, ascending: isInverted).execute();
    final tasks = response.data as List<dynamic>;
    List<Task> taskList = [];
    for (var taskData in tasks) {
      //print(taskData);
      taskList.add(Task(
          id: taskData['id'],
          content: taskData['content'],
          completed: taskData['completed'],
          title: taskData['title']));
    }
    return taskList;
  }

  Future<void> addTask(Task task) async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('Task').insert([
      {
        'title': task.title,
        'content': task.content,
        'completed': task.completed
      }
    ]);
  }

  Future<void> modifyTask(Task task) async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('Task').update({
      'title': task.title,
      'content': task.content,
      'completed': task.completed
    }).eq('id', task.id);
  }

  Future<void> deleteTask(Task task) async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('Task').delete().eq('id', task.id);
  }

  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
    String SUPABASE_URL = dotenv.get("SUPABASE_URL");
    String SUPABASE_API_KEY = dotenv.get("SUPABASE_API_KEY");
    await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_API_KEY);
  }
}

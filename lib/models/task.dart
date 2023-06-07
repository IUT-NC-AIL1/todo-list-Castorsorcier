class Task{
  int? id=0;
  String content='';
  bool completed=false;
  String? title='';

  Task({this.id, required this.content, required this.completed, this.title});
}
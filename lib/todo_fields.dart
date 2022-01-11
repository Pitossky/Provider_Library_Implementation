class TodoFields {
  static const createdTime = 'createdTime';
}

class ToDo {
  DateTime createdTime;
  String title;
  late String id;
  String description;
  bool completedTasks;

  ToDo({
    this.id = '',
    required this.createdTime,
    required this.title,
    this.description = '',
    this.completedTasks = false,
  });
}

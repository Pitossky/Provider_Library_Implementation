import 'package:flutter/cupertino.dart';
import 'package:todo_provider/todo_fields.dart';

class TodoItemsProvider with ChangeNotifier {
  final List<ToDo> _toDoList = [
    ToDo(
      createdTime: DateTime.now(),
      title: 'Read up!',
    ),
    ToDo(
      createdTime: DateTime.now(),
      title: 'Keep reading',
    ),
    ToDo(
        createdTime: DateTime.now(),
        title: 'Read up!',
        description: '''-Get book
      -Open book
      -Read book
      '''),
  ];

  List<ToDo> get toDoList => _toDoList
      .where(
        (toDoList) => toDoList.completedTasks == false,
      )
      .toList();

  List<ToDo> get completedToDos =>
      _toDoList.where((element) => element.completedTasks == true).toList();

  void addToDo(ToDo toDo) {
    _toDoList.add(toDo);
    notifyListeners();
  }

  void deleteToDo(ToDo toDo) {
    _toDoList.remove(toDo);
    notifyListeners();
  }

  bool toggleToDoStatus(ToDo toDo) {
    toDo.completedTasks = !toDo.completedTasks;
    notifyListeners();
    return toDo.completedTasks;
  }

  void updateToDo(ToDo toDo, String title, String description) {
    toDo.title = title;
    toDo.description = description;
    notifyListeners();
  }
}

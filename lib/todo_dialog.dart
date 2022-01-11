import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/todo_fields.dart';
import 'package:todo_provider/todo_form.dart';
import 'package:todo_provider/todo_items.dart';

class ToDoDialog extends StatefulWidget {
  @override
  _ToDoDialogState createState() => _ToDoDialogState();
}

class _ToDoDialogState extends State<ToDoDialog> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Todo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 8,
            ),
            ToDoForm(
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: addToDo,
            ),
          ],
        ),
      ),
    );
  }

  void addToDo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final toDo = ToDo(
        createdTime: DateTime.now(),
        title: title,
        id: DateTime.now().toString(),
      );
      final toDoListProvider = Provider.of<TodoItemsProvider>(
        context,
        listen: false,
      );
      toDoListProvider.addToDo(toDo);
      Navigator.of(context).pop();
    }
  }
}

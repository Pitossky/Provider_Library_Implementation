import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/todo_fields.dart';
import 'package:todo_provider/todo_form.dart';
import 'package:todo_provider/todo_items.dart';

class EditPage extends StatefulWidget {
  final ToDo toDo;

  EditPage({required this.toDo});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.toDo.title;
    description = widget.toDo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit ToDo',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ToDoForm(
            onChangedDescription: (description) => setState(() {
              this.description = description;
            }),
            onSavedTodo: saveToDo,
            onChangedTitle: (title) => setState(() {
              this.title = title;
            }),
            title: title,
            description: description,
          ),
        ),
      ),
    );

  }
  void saveToDo(){
    final isValid = _formKey.currentState!.validate();
    if(!isValid){
      return;
    }else{
      final formProvider = Provider.of<TodoItemsProvider>(context);
      formProvider.updateToDo(widget.toDo, title, description);
      Navigator.of(context).pop();
    }
  }
}

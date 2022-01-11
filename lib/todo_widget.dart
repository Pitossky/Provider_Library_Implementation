import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/todo_fields.dart';
import 'package:todo_provider/todo_items.dart';
import 'package:todo_provider/utils.dart';

import 'edit_page.dart';

class TodoWidget extends StatelessWidget {
  final ToDo myToDo;

  TodoWidget({required this.myToDo});

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => editToDo(context, myToDo),
                icon: Icons.edit,
                label: 'Edit',
                backgroundColor: Colors.green,
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => deleteToDo(context, myToDo),
                icon: Icons.delete,
                label: 'Delete',
                backgroundColor: Colors.red,
              ),
            ],
          ),
          key: Key(myToDo.id),
          child: buildAToDo(context),
        ),
      );

  Widget buildAToDo(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: myToDo.completedTasks,
              onChanged: (bool? value) {
                final toDoProvider = Provider.of<TodoItemsProvider>(
                  context,
                  listen: false,
                );
                final isDone = toDoProvider.toggleToDoStatus(myToDo);

                Utils.showSnackBar(
                  context,
                  isDone ? 'Task Completed' : 'Task Incomplete',
                );
              },
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    myToDo.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  if (myToDo.description.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Text(
                        myToDo.description,
                        style: const TextStyle(
                          fontSize: 20,
                          height: 1.5,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );

  void deleteToDo(BuildContext context, ToDo myToDo) {
    final toDoProvider = Provider.of<TodoItemsProvider>(
      context,
      listen: false,
    );
    toDoProvider.deleteToDo(myToDo);

    Utils.showSnackBar(context, 'Task Deleted');
  }

  void editToDo(BuildContext context, ToDo myToDo) =>
      Navigator.of(context).push(
    MaterialPageRoute(
        builder: (_) => EditPage(
            toDo: myToDo,
        ),
    )
  );
}

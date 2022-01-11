import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/todo_items.dart';
import 'package:todo_provider/todo_widget.dart';

class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toDoListProvider = Provider.of<TodoItemsProvider>(context);
    final completeToDoList = toDoListProvider.completedToDos;

    return completeToDoList.isEmpty
        ? const Center(
      child: Text(
        'No Completed Tasks',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    )
        : ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final todo = completeToDoList[index];
        return TodoWidget(myToDo: todo);
      },
      separatorBuilder: (context, index) => Container(
        height: 8,
      ),
      itemCount: completeToDoList.length,
    );
  }
}

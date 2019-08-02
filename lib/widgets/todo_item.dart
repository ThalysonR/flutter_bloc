import 'package:flutter/material.dart';
import 'package:flutter_architecture/keys.dart';
import 'package:flutter_architecture/models/todo.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Todo todo;

  TodoItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.todo
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: PmzSampleKeys.todoItem(todo.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(key: PmzSampleKeys.todoItemCheckbox(todo.id), value: todo.complete, onChanged: onCheckboxChanged),
        title: Text(
          todo.task,
          key: PmzSampleKeys.todoItemTask(todo.id),
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          todo.note,
          key: PmzSampleKeys.todoItemNote(todo.id),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
    );
  }
}
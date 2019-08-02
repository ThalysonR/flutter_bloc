import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/keys.dart';
import 'package:flutter_architecture/localization.dart';
import 'package:flutter_architecture/models/todo.dart';
import 'package:flutter_architecture/widgets/loading.dart';
import 'package:flutter_architecture/widgets/todo_item.dart';
import 'package:flutter_architecture/widgets/todos_bloc_provider.dart';

class TodoList extends StatelessWidget {
  TodoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
        stream: TodosBlocProvider
            .of(context)
            .visibleTodos,
        builder: (context, snapshot) =>
        snapshot.hasData
            ? _buildList(snapshot.data)
            : LoadingSpinner(key: PmzSampleKeys.todosLoading)
    );
  }
}

ListView _buildList(List<Todo> todos) {
  return ListView.builder(
    key: PmzSampleKeys.todoList,
    itemCount: todos.length,
    itemBuilder: (BuildContext context, int index) {
      final todo = todos[index];

      return TodoItem(
        todo: todo,
        onDismissed: (direction) {
          _removeTodo(context, todo);
        },
//        onTap: () {
//          Navigator.of(context).push(
//            MaterialPageRoute(
//              builder: DetailScreen
//            )
//          )
//        }
      );
    },
  );
}

void _removeTodo(BuildContext context, Todo todo) {
  TodosBlocProvider
      .of(context)
      .deleteTodo
      .add(todo.id);

  _showUndoSnackBar(context, todo);
}

void _showUndoSnackBar(BuildContext context, Todo todo) {
  final snackBar = SnackBar(
    key: PmzSampleKeys.snackbar,
    duration: Duration(seconds: 2),
    backgroundColor: Theme
        .of(context)
        .backgroundColor,
    content: Text(
      BlocLocalizations.of(context).todoDeleted(todo.task),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    action: SnackBarAction(
      key: PmzSampleKeys.snackbarAction(todo.id),
      label: BlocLocalizations
          .of(context)
          .undo,
      onPressed: () {
        TodosBlocProvider
            .of(context)
            .addTodo
            .add(todo);
      },
    ),
  );

  Scaffold.of(context).showSnackBar(snackBar);
}
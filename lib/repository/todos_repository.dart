import 'dart:async';

import 'package:flutter_architecture/repository/todo_entity.dart';

abstract class TodosRepository {
  Future<List<TodoEntity>> loadTodos();

  Future saveTodos(List<TodoEntity> todos);
}
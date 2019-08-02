import 'package:flutter_architecture/repository/todo_entity.dart';
import 'package:flutter_architecture/repository/todos_repository.dart';
import 'package:meta/meta.dart';

import 'file_storage.dart';

class TodosRepositoryFlutter implements TodosRepository {
  final FileStorage fileStorage;

  const TodosRepositoryFlutter({
    @required this.fileStorage
});

  @override
  Future<List<TodoEntity>> loadTodos() async {
    try {
      return await fileStorage.loadTodos();
    } catch (e) {

      fileStorage.saveTodos([]);

      return [];
    }
  }

  @override
  Future saveTodos(List<TodoEntity> todos) {
    return fileStorage.saveTodos(todos);
  }
}
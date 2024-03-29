import 'package:flutter_architecture/repository/reactive_todos_repository.dart';
import 'todo_entity.dart';
import 'todos_repository.dart';
import 'package:rxdart/subjects.dart';
import 'dart:async';
import 'package:meta/meta.dart';

class ReactiveTodosRepositoryFlutter implements ReactiveTodosRepository {
  final TodosRepository _repository;
  final BehaviorSubject<List<TodoEntity>> _subject;
  bool _loaded = false;

  ReactiveTodosRepositoryFlutter({
    @required TodosRepository repository,
    List<TodoEntity> seedValue,
}) : this._repository = repository, this._subject = BehaviorSubject<List<TodoEntity>>.seeded(seedValue);

  @override
  Future<void> addNewTodo(TodoEntity todo) async {
    _subject.add(List.unmodifiable([]
    ..addAll(_subject.value ?? [])
    ..add(todo)));

    await _repository.saveTodos(_subject.value);
  }

  @override
  Future<void> deleteTodo(List<String> idList) async {
    _subject.add(
      List<TodoEntity>.unmodifiable(_subject.value.fold<List<TodoEntity>>(<TodoEntity>[], (prev, entity) {
        return idList.contains(entity.id) ? prev : (prev..add(entity));
      }))
    );

    await _repository.saveTodos(_subject.value);
  }

  @override
  Stream<List<TodoEntity>> todos() {
    if (!_loaded) _loadTodos();

    return _subject.stream;
  }

  void _loadTodos() {
    _loaded = true;

    _repository.loadTodos().then((entities) {
      _subject.add(List<TodoEntity>.unmodifiable(
        []..addAll(_subject.value ?? [])..addAll(entities),
      ));
    });
  }

  @override
  Future<void> updateTodo(TodoEntity update) async {
    _subject.add(
      List<TodoEntity>.unmodifiable(_subject.value.fold<List<TodoEntity>>(<TodoEntity>[], (prev, entity) => prev..add(entity.id == update.id ? update : entity)))
    );

    await _repository.saveTodos(_subject.value);
  }
}

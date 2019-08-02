import 'dart:async';

import 'package:flutter_architecture/blocs/todos_interactor.dart';
import 'package:flutter_architecture/blocs/todos_list_bloc.dart';
import 'package:flutter_architecture/models/todo.dart';
import 'package:flutter_architecture/repository/reactive_todos_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockReactiveTodosRepository extends Mock implements ReactiveTodosRepository {}

class MockTodosListInteractor extends Mock implements TodosInteractor {}

void main() {
  group('TodosListBloc', () {
    test('should display all todos by default', () {
      final interactor = MockTodosListInteractor();
      final todos = [Todo('Hello')];

      when(interactor.todos).thenAnswer((_) => Stream.fromIterable([todos]));

      final bloc = TodosListBloc(interactor);

      expect(bloc.visibleTodos, emits(todos));
    });
  });
}
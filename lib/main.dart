import 'package:flutter/material.dart';
import 'package:flutter_architecture/dependency_injection.dart';
import 'package:flutter_architecture/repository/file_storage.dart';
import 'package:flutter_architecture/repository/reactive_todos_repository.dart';
import 'package:flutter_architecture/repository/reactive_todos_repository_impl.dart';
import 'package:flutter_architecture/repository/todos_repository_impl.dart';
import 'package:flutter_architecture/repository/user_entity.dart';
import 'package:flutter_architecture/repository/user_repository.dart';
import 'package:flutter_architecture/routes.dart';
import 'package:flutter_architecture/screens/HomeScreen.dart';
import 'package:flutter_architecture/screens/add_edit_screen.dart';
import 'package:flutter_architecture/widgets/todos_bloc_provider.dart';
import 'package:flutter_architecture/blocs/index.dart';
import 'package:flutter_architecture/localization.dart';
import 'package:flutter_architecture/theme.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  TodosInteractor interactor = TodosInteractor(getRepository());
  UserRepository userRepository = AnonymousUserRepository();

  runApp(Injector(
      todosInteractor: interactor,
      userRepository: userRepository,
      child: TodosBlocProvider(
        bloc: TodosListBloc(interactor),
        child: MaterialApp(
          title: BlocLocalizations().appTitle,
          theme: PmzTheme.theme,
          localizationsDelegates: [InheritedWidgetLocalizationsDelegate()],
          routes: {
            PmzRoutes.home: (context) {
              return HomeScreen(
                repository: Injector.of(context).userRepository,
              );
            },
            PmzRoutes.addTodo: (context) {
              return AddEditScreen(
                addTodo: TodosBlocProvider.of(context).addTodo.add,
              );
            }
          },
        ),
      )));
}

ReactiveTodosRepository getRepository() {
  return ReactiveTodosRepositoryFlutter(
      repository: TodosRepositoryFlutter(
          fileStorage: FileStorage(
              '__bloc_local_storage', getApplicationDocumentsDirectory)));
}

class AnonymousUserRepository implements UserRepository {
  @override
  Future<UserEntity> login() {
    return Future.value(UserEntity(id: 'anonymous'));
  }
}

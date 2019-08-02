library dependency_injector;

import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/repository/user_repository.dart';

import 'blocs/todos_interactor.dart';

class Injector extends InheritedWidget {
  final TodosInteractor todosInteractor;
  final UserRepository userRepository;

  Injector({
    Key key,
    @required this.todosInteractor,
    @required this.userRepository,
    @required Widget child,
}) : super(key: key, child: child);

  static Injector of(BuildContext context) => context.inheritFromWidgetOfExactType(Injector);

  @override
  bool updateShouldNotify(Injector oldWidget) => false;
}
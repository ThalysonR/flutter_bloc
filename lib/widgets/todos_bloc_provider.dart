import 'package:flutter/material.dart';
import 'package:flutter_architecture/blocs/index.dart';

class TodosBlocProvider extends StatefulWidget {
  final Widget child;
  final TodosListBloc bloc;

  TodosBlocProvider({Key key, @required this.child, @required this.bloc}) : super(key: key);

  @override
  _TodosBlocProviderState createState() => _TodosBlocProviderState();

  static TodosListBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_TodosBlocProvider) as _TodosBlocProvider).bloc;
  }
}

class _TodosBlocProviderState extends State<TodosBlocProvider> {
  @override
  Widget build(BuildContext context) {
    return _TodosBlocProvider(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

class _TodosBlocProvider extends InheritedWidget {
  final TodosListBloc bloc;

  _TodosBlocProvider({Key key, @required this.bloc, @required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_TodosBlocProvider oldWidget) => bloc != oldWidget.bloc;
}
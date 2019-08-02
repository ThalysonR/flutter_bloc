import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/blocs/todos_list_bloc.dart';
import 'package:flutter_architecture/blocs/user_bloc.dart';
import 'package:flutter_architecture/models/app_tab.dart';
import 'package:flutter_architecture/models/visibility_filter.dart';
import 'package:flutter_architecture/repository/user_entity.dart';
import 'package:flutter_architecture/repository/user_repository.dart';
import 'package:flutter_architecture/localization.dart';
import 'package:flutter_architecture/routes.dart';
import 'package:flutter_architecture/widgets/todo_list.dart';

import '../keys.dart';

class HomeScreen extends StatefulWidget {
  final UserRepository repository;

  HomeScreen({@required this.repository}) : super(key: PmzSampleKeys.homeScreen);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  UserBloc usersBloc;
  StreamController<AppTab> tabController;

  @override
  void initState() {
    super.initState();

    usersBloc = UserBloc(widget.repository);
    tabController = StreamController<AppTab>();
  }

  @override
  void dispose() {
    tabController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserEntity>(
      stream: usersBloc.login(),
      builder: (context, userSnapshot) {
        return StreamBuilder<AppTab>(
          initialData: AppTab.todos,
          stream: tabController.stream,
          builder: (context, activeTabSnapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text(BlocLocalizations.of(context).appTitle),
              ),
              body: userSnapshot.hasData
              ? activeTabSnapshot.data == AppTab.todos
              ? TodoList() : null : null,
              floatingActionButton: FloatingActionButton(
                key: PmzSampleKeys.addTodoFab,
                onPressed: () {
                  Navigator.pushNamed(context, PmzRoutes.addTodo);
                },
                child: Icon(Icons.add),
                tooltip: BlocLocalizations.of(context).addTodo,
              ),
            );
          },
        );
      },
    );
  }
}

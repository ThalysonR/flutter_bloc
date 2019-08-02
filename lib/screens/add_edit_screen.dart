import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/keys.dart';
import 'package:flutter_architecture/localization.dart';
import 'package:flutter_architecture/models/todo.dart';

class AddEditScreen extends StatefulWidget {
  final Todo todo;
  final Function(Todo) addTodo;
  final Function(Todo) updateTodo;

  AddEditScreen({
    Key key,
    this.todo,
    this.addTodo,
    this.updateTodo,
  }) : super(key: key ?? PmzSampleKeys.addTodoScreen);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
            ? BlocLocalizations.of(context).editTodo
            : BlocLocalizations.of(context).addTodo
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidate: false,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: widget.todo != null ? widget.todo.task : '',
                key: PmzSampleKeys.taskField,
                autofocus: isEditing ? false : true,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                  hintText: BlocLocalizations.of(context).newTodoHint,
                ),
                validator: (val) => val.trim().isEmpty
                  ? BlocLocalizations.of(context).emptyTodoError
                  : null,
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: widget.todo != null ? widget.todo.note : '',
                key: PmzSampleKeys.noteField,
                maxLines: 10,
                style: Theme.of(context).textTheme.subhead,
                decoration: InputDecoration(
                  hintText: BlocLocalizations.of(context).notesHint,
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: isEditing ? PmzSampleKeys.saveTodoFab : PmzSampleKeys.saveNewTodo,
        tooltip: isEditing ? BlocLocalizations.of(context).saveChanges : BlocLocalizations.of(context).addTodo,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          final form = formKey.currentState;
          if (form.validate()) {
            form.save();

            if (isEditing) {
              widget.updateTodo(widget.todo.copyWith(task: _task, note: _note));
            } else {
              widget.addTodo(Todo(_task, note: _note));
            }
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  bool get isEditing => widget.todo != null;
}
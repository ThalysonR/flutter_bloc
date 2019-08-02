import 'package:flutter/material.dart';

class BlocLocalizations {
  get undo => "Undo";

  get addTodo => "Add Todo";

  get editTodo => "Edit Todo";

  get newTodoHint => "Add new Todo";

  get emptyTodoError => "Enter a Todo";

  get notesHint => "Add todo's note";

  get saveChanges => "Save changes";

  static BlocLocalizations of(BuildContext context) {
    return Localizations.of<BlocLocalizations>(context, BlocLocalizations);
  }

  String get appTitle => "Bloc Example";

  String todoDeleted(String todo) => todo;
}

class InheritedWidgetLocalizationsDelegate extends LocalizationsDelegate<BlocLocalizations> {
  @override
  Future<BlocLocalizations> load(Locale locale) => Future(() => BlocLocalizations());

  @override
  bool shouldReload(LocalizationsDelegate<BlocLocalizations> old) => false;

  @override
  bool isSupported(Locale locale) => locale.languageCode.toLowerCase().contains("en");
}
import 'package:flutter_architecture/repository/user_entity.dart';
import 'package:flutter_architecture/repository/user_repository.dart';

class UserBloc {
  final UserRepository _repository;

  Stream<UserEntity> login() => _repository.login().asStream().asBroadcastStream();

  UserBloc(UserRepository repository) : this._repository = repository;
}
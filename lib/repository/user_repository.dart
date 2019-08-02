import 'dart:async';

import 'package:flutter_architecture/repository/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> login();
}
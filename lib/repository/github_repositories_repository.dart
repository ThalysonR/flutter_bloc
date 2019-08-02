import 'package:flutter_architecture/models/github_node.dart';

abstract class GithubRepositoriesRepository {
  Stream<List<GithubNode>> nodes();
}
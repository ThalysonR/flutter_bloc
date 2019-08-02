import 'package:flutter_architecture/models/github_node.dart';
import 'package:flutter_architecture/repository/github_repositories_repository.dart';

class GithubRepositoriesBloc {
  final GithubRepositoriesRepository repository;

  GithubRepositoriesBloc(this.repository);

  Stream<List<GithubNode>> get nodes => repository.nodes();
}
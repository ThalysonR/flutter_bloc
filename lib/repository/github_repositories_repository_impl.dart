import 'package:flutter_architecture/models/github_node.dart';
import 'package:flutter_architecture/repository/github_repositories_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rxdart/subjects.dart';
import 'package:meta/meta.dart';

class GithubRepositoriesRepositoryImpl implements GithubRepositoriesRepository {
  final BehaviorSubject<List<GithubNode>> _subject =
      BehaviorSubject<List<GithubNode>>();
  final GraphQLClient graphQLClient;
  bool _loaded = false;

  GithubRepositoriesRepositoryImpl({@required GraphQLClient gqlClient})
      : this.graphQLClient = gqlClient;

  @override
  Stream<List<GithubNode>> nodes() {
    if (!_loaded) {
      _loadNodes();
    }

    return _subject.stream;
  }

  void _loadNodes() async {
    final QueryResult result = await graphQLClient.query(QueryOptions(
      document: _getNodesQuery,
      variables: {
        'nRepositories': 10
      }
    ));

    if (result.errors == null) {
      List<GithubNode> repoList = List<GithubNode>();
      result.data['viewer']['repositories']['nodes'].forEach((v) => repoList.add(GithubNode(v['id'], v['name'], v['viewerHasStarred'])));
      _subject.add(List<GithubNode>.unmodifiable(
        []..addAll(repoList)
      ));
    }
  }
}

String _getNodesQuery = """
  query ReadRepositories(\$nRepositories: Int!) {
    viewer {
      repositories(last: \$nRepositories) {
        nodes {
          id
          name
          viewerHasStarred
        }
      }
    }
  }
""";

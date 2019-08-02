import 'package:flutter/material.dart';
import 'package:flutter_architecture/blocs/github_repositories_bloc.dart';
import 'package:flutter_architecture/repository/github_repositories_repository_impl.dart';
import 'package:flutter_architecture/widgets/github_repositories_list.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GithubRepositoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Github Repositories"),
      ),
      body: GithubRepositoriesList(
        bloc: GithubRepositoriesBloc(GithubRepositoriesRepositoryImpl(gqlClient: _createGraphQLClient())),
      )
    );
  }
}

GraphQLClient _createGraphQLClient() {
  final HttpLink httpLink = HttpLink(uri: 'https://api.github.com/graphql');

  String apiToken = DotEnv().env['GITHUB_API'];

  final AuthLink authLink = AuthLink(
    getToken: () => 'token $apiToken'
  );

  final Link link = authLink.concat(httpLink);
  return GraphQLClient(cache: InMemoryCache(), link: link);
}
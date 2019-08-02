import 'package:flutter/material.dart';
import 'package:flutter_architecture/blocs/github_repositories_bloc.dart';
import 'package:flutter_architecture/models/github_node.dart';
import 'package:flutter_architecture/widgets/loading.dart';

class GithubRepositoriesList extends StatelessWidget {
  final GithubRepositoriesBloc bloc;

  GithubRepositoriesList({@required GithubRepositoriesBloc bloc, Key key})
      : this.bloc = bloc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GithubNode>>(
      stream: bloc.nodes,
      builder: (context, snapshot) =>
        snapshot.hasData
            ? _buildList(snapshot.data)
            : LoadingSpinner()
    );
  }
}

ListView _buildList(List<GithubNode> nodes) {
  return ListView.builder(
    itemCount: nodes.length,
    itemBuilder: (BuildContext context, int index) {
      final node = nodes[index];

      return ListTile(
        title: Text(node.name),
        leading: Text(node.id.toString()),
      );
    },
  );
}

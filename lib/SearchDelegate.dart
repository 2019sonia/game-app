import 'package:flutter/material.dart';
import 'package:untitled/game_widget_builder.dart';

import 'model/view_game.dart';
import 'network/network_request.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    Future<List<ViewGame>> searchGames = NetworkRequest.fetchViewGames(query.toString());

    return FutureBuilder(
      builder: (context, AsyncSnapshot<List<ViewGame>> snapshot) {
        if (snapshot.hasData) {
          return GameListBuilder.buildListViewGames(snapshot, context, searchGames);
        } else if (snapshot.hasError) {
          return const Text('Something went wrong :(');
        }
        return CircularProgressIndicator();
      },
      future: searchGames,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Column();
  }
}
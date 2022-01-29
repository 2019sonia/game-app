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
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
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
          var length = snapshot.data?.length ?? 0;
          if(length != 0){
            return GameListBuilder.buildListViewGames(snapshot, context, searchGames);
          }
          return const Center(
            child: Text('No games found :(',
                style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
          );

        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong :('));
        }
        return const Center(child: CircularProgressIndicator());
      },
      future: searchGames,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
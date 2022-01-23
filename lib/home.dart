import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/model/grid_view_game.dart';
import 'package:untitled/network/network_request.dart';
import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'model/game.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();    // TODO: implement createState

  HomePage({Key? key}) : super(key: key);
}

class _HomePageState extends State<HomePage> {
  late Future<List<GridViewGame>> games;

  @override
  void initState() {
    super.initState();
    games = NetworkRequest.fetchGridViewGames("Batman");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Search"),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: Container(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: FutureBuilder(
                      builder: (context, AsyncSnapshot<List<GridViewGame>> snapshot) {
                        if (snapshot.hasData) {
                          return Helper.buildListViewGridViewGames(snapshot, context, games);
                        } else if (snapshot.hasError) {
                          return const Text('Something went wrong :(');
                        }
                        return CircularProgressIndicator();
                      },
                      future: games,
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}

class Helper{
  static Widget buildListViewGridViewGames(AsyncSnapshot<List<GridViewGame>> snapshot, BuildContext context, Future<List<GridViewGame>> games) =>
      FutureBuilder(
        builder: (context, AsyncSnapshot<List<GridViewGame>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return buildGame(snapshot, index, context);
              },
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
            );
          } else if (snapshot.hasError) {
            return Text('Something went wrong :(');
          }
          return CircularProgressIndicator();
        },
        future: games,
      );

  static Widget buildGame(AsyncSnapshot<List<GridViewGame>> snapshot, int index, BuildContext context) =>
      GestureDetector(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage:
            NetworkImage('${snapshot.data?[index].thumb}'),
          ),
          title: Text('${snapshot.data?[index].external}'),
          subtitle: Text('Cheapest price: ${snapshot.data?[index].cheapest}'),
        ),
        onTap: () {
          showGameInfo(snapshot.data?[index].gameID, context);
        }
      );

  static showGameInfo(String? id, BuildContext context) {
    //TODO: Change parameters as needed, maybe pass Game object (which need to be created)

    Future<Game> game = NetworkRequest.fetchGame(int.parse(id!));

    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.7,
                  height: 320,
                  child: FutureBuilder(
                    builder: (context, AsyncSnapshot<Game> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                '${snapshot.data?.info?.thumb}', width: 140,
                                height: 120,
                                fit: BoxFit.cover,),
                            ),
                            SizedBox(height: 10,),
                            Expanded(
                              child: AutoSizeText(
                                  '${snapshot.data?.info?.title}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                minFontSize: 20,
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "price, store, url?", //TODO: Change game details
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            IconButton(
                              icon: Icon(Icons.favorite),
                              //TODO: Filled/Not filled heart depending if it's a favortie or not
                              color: Colors.red,
                              iconSize: 45,
                              onPressed: () {}, //TODO: Add as favourite / Delete from favorites in the Firebase DB
                            ),
                          ],
                        );
                      }else if (snapshot.hasError){
                        return Text('Something went wrong :(');
                      }
                      return CircularProgressIndicator();
                    },
                    future: game,
                  )
              ),
            ),
          );
        }

    );
  }
}

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

    Future<List<GridViewGame>> searchGames = NetworkRequest.fetchGridViewGames(query.toString());

    return FutureBuilder(
      builder: (context, AsyncSnapshot<List<GridViewGame>> snapshot) {
        if (snapshot.hasData) {
          return Helper.buildListViewGridViewGames(snapshot, context, searchGames);
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
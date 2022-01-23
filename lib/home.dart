import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/model/grid_view_game.dart';
import 'dart:convert';
import 'package:untitled/network/network_request.dart';

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
        appBar: AppBar( // TODO: Feel free to delete it and replace it with another search bar
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
                          return buildGridView();
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

  Widget buildGridView() =>
      FutureBuilder(
        builder: (context, AsyncSnapshot<List<GridViewGame>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                    NetworkImage('${snapshot.data?[index].thumb}'),
                  ),
                  title: Text('${snapshot.data?[index].external}'),
                  subtitle: Text('Cheapest price: ${snapshot.data?[index].cheapest}'),
                );
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

  Widget buildGame(AsyncSnapshot snapshot, int index) =>
      Card(
        color: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage( //TODO: Change game image (line below)
                  image: NetworkImage(
                      'https://play-lh.googleusercontent.com/V-lvUzA5kK0Xw3wdg8Ct3vfIMXUX5vXYcNLPmudaZ-eyQjedYz-luqIuLmJO6KodE0Y'),
                  fit: BoxFit.cover,
                ),
              ),

              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${snapshot.data?[index].title}', // TODO: Change price name
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      backgroundColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),

              ),
            ),
            onTap: () {
              showGameInfo(context);
            }
        ),
      );

  showGameInfo(BuildContext context) {
    //TODO: Change parameters as needed, maybe pass Game object (which need to be created)
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'assets/logo.png', width: 120,
                          height: 120,
                          //TODO: Change game image
                          fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 5,),
                      Text(
                          "Game", //TODO: Change game name
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          )
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

    return FutureBuilder<List<Game>>(
      future: _search(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("snapshot.data[index].name"),
                onTap: () {
                  close(context, snapshot.data);
                },
              );
            },
            itemCount: 1,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Column();
  }

  Future<List<Game>> _search() async {
    final authority = 'jsonplaceholder.typicode.com';
    final path = 'todos';
    final queryParameters = <String, String>{'title': query};
    final uri = Uri.https(authority, path, queryParameters);
    final result = await http.get(uri);
    final list = json.decode(result.body) as List;
    return list.map((e) => Game.fromJson(e)).toList();
  }
}
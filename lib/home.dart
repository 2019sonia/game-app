import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/game_widget_builder.dart';
import 'package:untitled/model/view_game.dart';
import 'package:untitled/network/network_request.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'SearchDelegate.dart';
import 'model/game.dart';
import 'dart:convert';

import 'model/store.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

  HomePage({Key? key}) : super(key: key);
}

class _HomePageState extends State<HomePage> {
  late Future<List<ViewGame>> games;

  @override
  void initState() {
    super.initState();
    games = NetworkRequest.fetchViewGames("Batman");
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
                SizedBox(height: 15,),
                Center(
                  child: Text(
                    "Suggested Games",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10,),
              //const Divider(),
                Expanded(
                  child: Center(
                    child: FutureBuilder(
                      builder: (context, AsyncSnapshot<List<ViewGame>> snapshot) {
                        if (snapshot.hasData) {
                          return GameListBuilder.buildListViewGames(snapshot, context, games);
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
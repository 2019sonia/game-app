import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'DAO/GameDAO.dart';
import 'game_widget_builder.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();

  FavoritePage({Key? key}) : super(key: key);

}

class _FavoritePageState extends State<FavoritePage> {
  late Future<DataSnapshot> games_ids;

  @override
  void initState() {
    super.initState();
    games_ids = GameDAO.getData();
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Favorite Games"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: FutureBuilder(
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data?.value == null){
                        return const Center(
                          child: Text('No games saved :(',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        );
                      }
                      Map<dynamic, dynamic> values = snapshot.data?.value;
                      List<int> ids = [];
                      values.forEach((k, v) => ids.add( int.parse(k)));

                      return GameListBuilder.buildGridViewGames(context, ids);

                    }else if (snapshot.hasError) {
                      return const Icon(Icons.error);
                    }
                    return const CircularProgressIndicator();
                  },
                  future: games_ids,
                ),
              ),
            ),
          ],
        )
    );
  }
}
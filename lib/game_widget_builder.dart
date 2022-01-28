import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'DAO/GameDAO.dart';
import 'FavoriteIcon.dart';
import 'model/game.dart';
import 'model/list_view_game.dart';
import 'network/network_request.dart';

class GameListBuilder {

  static Widget buildListViewGridViewGames(
      AsyncSnapshot<List<ListViewGame>> snapshot, BuildContext context,
      Future<List<ListViewGame>> games) =>
      FutureBuilder(
        builder: (context, AsyncSnapshot<List<ListViewGame>> snapshot) {
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

  static Widget buildGame(AsyncSnapshot<List<ListViewGame>> snapshot, int index,
      BuildContext context) =>
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
            GameDialogBuilder.showGameInfo(snapshot.data?[index].gameID, context);
          }
      );
}

class GameDialogBuilder {
  static showGameInfo(String? id, BuildContext context) {

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
                            FutureBuilder(
                              builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
                                if(snapshot.data?.value == null){
                                  return FavoriteIcon(
                                      true_or_false: false, game_id: id);
                                } else if (snapshot.hasData) {
                                  Map<dynamic, dynamic> values = snapshot.data?.value;
                                  bool flag = false;
                                  values.forEach((key, value){
                                    if(value == id){
                                      flag = true;
                                    }
                                  });
                                  if(flag){
                                    return FavoriteIcon(
                                        true_or_false: true, game_id: id);
                                  }
                                  return FavoriteIcon(
                                      true_or_false: false, game_id: id);
                                }else if (snapshot.hasError) {
                                  return const Icon(Icons.error);
                                }
                                return const CircularProgressIndicator();
                              },
                              future: GameDAO.getData(),
                            )
                          ],
                        );
                      }else if (snapshot.hasError){
                        return Text('Something went wrong :(');
                      }
                      //TODO format
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
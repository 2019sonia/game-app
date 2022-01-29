import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'DAO/GameDAO.dart';
import 'FavoriteIcon.dart';
import 'model/game.dart';
import 'model/store.dart';
import 'model/view_game.dart';
import 'network/network_request.dart';

class GameListBuilder {

  static Widget buildListViewGames(
      AsyncSnapshot<List<ViewGame>> snapshot, BuildContext context,
      Future<List<ViewGame>> games) =>
      FutureBuilder(
        builder: (context, AsyncSnapshot<List<ViewGame>> snapshot) {
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
            return const Center(child: Text('Something went wrong :('));
          }
          return CircularProgressIndicator();
        },
        future: games,
      );

  static Widget buildListStores(AsyncSnapshot<List<Store>> stores, AsyncSnapshot<Game> game) {

    var length = game.data?.deals?.length ?? 0;

    if(length == 0){
      return const Center(child: Text('Something went wrong :('));
    }else{
      if (length > 3) {
        length = 3;
      }

      return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200, minHeight: 56.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(5),
          itemCount: length,
          itemBuilder: (BuildContext context, int index) {
            String imageStore = "https://www.cheapshark.com/" + (stores.data?[index].images?.logo ?? "");
            String price = "\$" + (game.data?.deals![index].price ?? "");

            return ListTile(
              leading: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    imageStore, width: 40,
                    height: 32,
                    fit: BoxFit.cover,),
                ),
              ),
              title: Align(
                  alignment: Alignment.centerRight,
                  child: Text(price, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
              )
            );
          },
        ),
      );
    }
  }




  static Widget buildGridViewGames(BuildContext context,
      List<int> ids)
  {
    Future<List<Game>> games = NetworkRequest.fetchGames(ids);

    return FutureBuilder(
      builder: (context, AsyncSnapshot<List<Game>> snapshot){
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return buildFavoriteGame(snapshot, index, ids[index], context);
            },
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong :('));
        }
        return const CircularProgressIndicator();
      },
      future: games,
    );
  }

  static Widget buildFavoriteGame(AsyncSnapshot<List<Game>> snapshot, int index, int id,
      BuildContext context) =>
      GestureDetector(
          child:
          Card(
            color: Colors.transparent,
            elevation: 0,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: const Radius.circular(20.0),topRight: const Radius.circular(20.0)),
                      image: DecorationImage(
                        image: NetworkImage('${snapshot.data?[index].info?.thumb}'),
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.withOpacity(0.4),
                    borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(20.0), bottomRight: const Radius.circular(20.0)),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        '\$${snapshot.data?[index].deals?.first.price}',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            GameDialogBuilder.showGameInfo(id.toString(), context);
          }
      );

  static Widget buildGame(AsyncSnapshot<List<ViewGame>> snapshot, int index,
      BuildContext context) =>
      GestureDetector(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage:
              NetworkImage('${snapshot.data?[index].thumb}'),
            ),
            title: Text('${snapshot.data?[index].external}'),
            subtitle: Text('Cheapest price: \$${snapshot.data?[index].cheapest}'),
          ),
          onTap: () {
            GameDialogBuilder.showGameInfo(snapshot.data?[index].gameID, context);
          }
      );
}

class GameDialogBuilder {
  static showGameInfo(String? id, BuildContext context) {

    Future<Game> game = NetworkRequest.fetchGame(int.parse(id!));
    String base_url_deal = "https://www.cheapshark.com/redirect?dealID=";

    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/1.5, minHeight: 56.0, maxWidth: MediaQuery
                    .of(context)
                    .size
                    .width * 0.7),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                padding: const EdgeInsets.all(10),
                child: Material(
                  type: MaterialType.transparency,
                  child: FutureBuilder(
                      builder: (context, AsyncSnapshot<Game> gameSnapshot) {
                        if (gameSnapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  '${gameSnapshot.data?.info?.thumb}', width: 140,
                                  height: 125,
                                  fit: BoxFit.cover,),
                              ),
                              const SizedBox(height: 10,),
                              AutoSizeText(
                                '${gameSnapshot.data?.info?.title}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                                minFontSize: 20,
                                maxLines: 2,
                              ),

                              const SizedBox(height: 10,),

                              FutureBuilder(
                                builder: (context, AsyncSnapshot<List<Store>> snapshot){
                                  if (snapshot.hasData) {

                                    var length = snapshot.data?.length ?? 0;

                                    if(length == 0){
                                      return const Icon(Icons.error);
                                    }else{
                                      return GameListBuilder.buildListStores(snapshot, gameSnapshot);
                                    }

                                  }else if (snapshot.hasError) {
                                    return const Icon(Icons.error);
                                  }
                                  return Container(
                                      constraints: const BoxConstraints(maxHeight: 40),
                                      child: const Center(child: CircularProgressIndicator()));
                                },
                                future: NetworkRequest.fetchStores(),
                              ),

                              const SizedBox(height: 10,),

                              FutureBuilder(
                                builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
                                   if (snapshot.hasData) {
                                      if(snapshot.data?.value == null){
                                       return Expanded(
                                         child: FavoriteShareIcon(
                                         true_or_false: false,
                                         game_id: id,
                                         game_name: gameSnapshot.data?.info?.title ?? "Not found!",
                                         price: gameSnapshot.data?.deals?.first.price ?? "Not found!",
                                         url: base_url_deal + (gameSnapshot.data?.deals?.first.dealID ?? "Not found!"),),
                                       );
                                      }
                                      Map<dynamic, dynamic> values = snapshot.data?.value;
                                      bool flag = false;
                                      values.forEach((key, value){
                                        if(value == id){
                                          flag = true;
                                        }
                                      });
                                      if(flag){
                                        return Expanded(
                                          child: FavoriteShareIcon(
                                              true_or_false: true,
                                              game_id: id,
                                              game_name: gameSnapshot.data?.info?.title ?? "Not found!",
                                              price: gameSnapshot.data?.deals?.first.price ?? "Not found!",
                                          url: base_url_deal + (gameSnapshot.data?.deals?.first.dealID ?? "Not found!"),),
                                        );
                                      }
                                      return Expanded(
                                        child: FavoriteShareIcon(
                                          true_or_false: false,
                                          game_id: id,
                                          game_name: gameSnapshot.data?.info?.title ?? "Not found!",
                                          price: gameSnapshot.data?.deals?.first.price ?? "Not found!",
                                          url: base_url_deal + (gameSnapshot.data?.deals?.first.dealID ?? "Not found!"),),
                                      );
                                  }else if (snapshot.hasError) {
                                    return const Icon(Icons.error);
                                  }
                                  return Container(
                                      constraints: const BoxConstraints(maxHeight: 40),
                                      child: const Center(child: CircularProgressIndicator()));
                                },
                                future: GameDAO.getData(),
                              )
                            ],
                          );
                        }else if (gameSnapshot.hasError){
                          return Text('Something went wrong :(');
                        }
                        return Container(
                            constraints: BoxConstraints(maxHeight: 40),
                            child: const Center(child: CircularProgressIndicator()));
                      },
                      future: game,
                    ),
                ),
              ),
            ),
          );
        }
    );
  }
}
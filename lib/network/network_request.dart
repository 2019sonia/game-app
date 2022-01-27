import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/model/game.dart';
import 'package:untitled/model/list_view_game.dart';
class NetworkRequest{
  static const String authority = 'www.cheapshark.com';

  static List<ListViewGame> parseGridViewGames(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;

    List<ListViewGame> gridViewGames = list.map((model) => ListViewGame.fromJson(model)).toList();

    return gridViewGames;
  }

  static Future<List<ListViewGame>> fetchGridViewGames(String game_name) async {

    final path = '/api/1.0/games';
    final queryParameters = <String, String>{'title': game_name};
    final uri = Uri.https(authority, path, queryParameters);

    final result = await http.get(uri);

    if(result.statusCode == 200){
      return compute(parseGridViewGames, result.body);
    }else{
      throw Exception('RIP no games for u');
    }
  }

  static Game parseGame(String responseBody){
    var json_game = json.decode(responseBody) as dynamic;


    return Game(
      info: Info.fromJson(json_game['info']),
      cheapestPriceEver: CheapestPriceEver.fromJson(json_game['cheapestPriceEver']),
      deals: json_game['deals'].map<Deals>((model) => Deals.fromJson(model)).toList(),
    );
  }

  static Future<Game> fetchGame(int id) async {

    final path = '/api/1.0/games';
    final queryParameters = <String, String>{'id': id.toString()};
    final uri = Uri.https(authority, path, queryParameters);

    final result = await http.get(uri);

    if(result.statusCode == 200){
      return compute(parseGame, result.body);
    }else{
      throw Exception('RIP no game for u');
    }
  }

  static Future<bool> fetchFavorite(String id) async {
    var url = "https://games-2ec39-default-rtdb.europe-west1.firebasedatabase.app/"+"data.json";
    // Check if game in DB (favorited)

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      return parseFavourite(response.body, id);
    }else{
      // TODO CHANGE
      throw Exception('RIP no game for u');
    }
  }

  static Future<bool> saveFavouriteGame(String id) async {
    var url = "https://games-2ec39-default-rtdb.europe-west1.firebasedatabase.app/" +
        "data.json";
    // Check if game in DB (favorited)

    final response = await http.post(Uri.parse(url), body: json.encode({"game_id" : id}));

    if (response.statusCode == 200) {
      return parseFavourite(response.body, id);
    } else {
      // TODO CHANGE
      throw Exception('RIP no game for u');
    }
  }

  static bool parseFavourite(String message, String id) {

    if (message == "null") {
      return false;
    }

    var list = json.decode(message) as Map<String, dynamic>;

    if(list.containsKey(id)){
      return true;
    }
    return false;

  }
}
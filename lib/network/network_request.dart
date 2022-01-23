import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/model/game.dart';
import 'package:untitled/model/grid_view_game.dart';
class NetworkRequest{
  static const String authority = 'www.cheapshark.com';

  static List<GridViewGame> parseGridViewGames(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;

    List<GridViewGame> gridViewGames = list.map((model) => GridViewGame.fromJson(model)).toList();

    return gridViewGames;
  }

  static Future<List<GridViewGame>> fetchGridViewGames(String game_name) async {

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

    Game game = json_game.map((model) => Game.fromJson(model));

    return game;
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

}
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/DAO/GameDAO.dart';
import 'package:untitled/model/game.dart';
import 'package:untitled/model/store.dart';
import 'package:untitled/model/view_game.dart';

class NetworkRequest{

  static const String authority = 'www.cheapshark.com';
  static final gameDAO = GameDAO();

  static List<ViewGame> parseViewGames(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;

    List<ViewGame> gridViewGames = list.map((model) => ViewGame.fromJson(model)).toList();

    return gridViewGames;
  }

  static Future<List<ViewGame>> fetchViewGames(String game_name) async {

    final path = '/api/1.0/games';
    final queryParameters = <String, String>{'title': game_name};
    final uri = Uri.https(authority, path, queryParameters);

    final result = await http.get(uri);

    if(result.statusCode == 200){
      return compute(parseViewGames, result.body);
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
      throw Exception('Error!');
    }
  }

  static void saveFavouriteGame(String id) {
    try{
      gameDAO.saveGame(id);
    } catch(e) {
      throw Exception(e.toString());
    }
  }

  static void deleteFavouriteGame(String id) {
    try{
      gameDAO.deleteGame(id);
    } catch(e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<Game>> fetchGames(List<int> ids) async {

    final path = '/api/1.0/games';
    String path_ids = '';

    var i = ids.iterator;
    //iterate over the list
    while(i.moveNext()){
      path_ids += i.current.toString() + ',';
    }
    path_ids = path_ids.substring(0, path_ids.length - 1);
    
    final queryParameters = <String, String>{'ids': path_ids};
    final uri = Uri.https(authority, path, queryParameters);

    final result = await http.get(uri);

    if(result.statusCode == 200){
      return compute(parseFavorites, result.body);
    }else{
      throw Exception('Error!');
    }
  }

  static List<Game> parseFavorites(String responseBody){
    var list = json.decode(responseBody) as dynamic;

    List<Game> g = [];

    list.forEach((k, v) =>
      g.add(Game(
        info: Info.fromJson(v['info']),
        cheapestPriceEver: CheapestPriceEver.fromJson(v['cheapestPriceEver']),
        deals: v['deals'].map<Deals>((model) => Deals.fromJson(model)).toList(),
      ))
    );

    return g;
  }

  static Future<List<Store>> fetchStores() async {

    const path = '/api/1.0/stores';
    final uri = Uri.https(authority, path);

    final result = await http.get(uri);

    if(result.statusCode == 200){
      return compute(parseStores, result.body);
    }else{
      throw Exception('Error!');
    }
  }

  static List<Store> parseStores(String responseBody){
    var list = json.decode(responseBody) as List<dynamic>;

    List<Store> stores = list.map((model) => Store.fromJson(model)).toList();

    return stores;
  }
}
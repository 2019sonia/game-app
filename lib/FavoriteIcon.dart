import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/network/network_request.dart';

class FavoriteIcon extends StatefulWidget {

  bool true_or_false;
  String game_id;

  FavoriteIcon({required this.true_or_false, required this.game_id});

  @override
  _FavoriteIconState createState() => _FavoriteIconState();

}

class _FavoriteIconState extends State<FavoriteIcon>{

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){

        // favourite, so we un-fav
        if(widget.true_or_false){
          setState((){
            NetworkRequest.deleteFavouriteGame(widget.game_id);
            toggleFav();
          });

        }else{
          // not favourite, so we fav
          setState((){
            NetworkRequest.saveFavouriteGame(widget.game_id);
            toggleFav();
          });
        }
      },
      child: getFav(widget.true_or_false)
    );
  }

  Icon getFav(bool toggle) {
    return toggle ? Icon(Icons.favorite) : Icon(Icons.favorite_border);
  }

  void toggleFav(){
    widget.true_or_false ? Icon(Icons.favorite) : Icon(Icons.favorite_border);
    widget.true_or_false = !widget.true_or_false;
  }

}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/network/network_request.dart';
import 'package:share_plus/share_plus.dart';

class FavoriteShareIcon extends StatefulWidget {

  bool true_or_false;
  String game_id;
  String game_name;
  String price;
  String url;

  FavoriteShareIcon({required this.true_or_false, required this.game_id, required this.game_name, required this.price, required this.url});

  @override
  _FavoriteShareIconState createState() => _FavoriteShareIconState();

}

class _FavoriteShareIconState extends State<FavoriteShareIcon>{

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ 
        GestureDetector(
          onTap: (){
            // favourite, so we un-fav
            if(widget.true_or_false){
              setState((){
                NetworkRequest.deleteFavouriteGame(widget.game_id);
                toggleFav();
  
                Fluttertoast.showToast(
                    msg: "Removed from favorites",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1
                );
              });
  
            }else{
              // not favourite, so we fav
              setState((){
                NetworkRequest.saveFavouriteGame(widget.game_id);
                toggleFav();
  
                Fluttertoast.showToast(
                    msg: "Added to favorites",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1
                );
              });
            }
          },
          child: getFav(widget.true_or_false)
        ),
        SizedBox(width: 80),
        IconButton(
          onPressed: (){Share.share('Check out ' + widget.game_name + ' for ' + widget.price + '!: '  + widget.url);},
          icon: const Icon(Icons.share, size: 30)
        )
      ]
    );
  }

  Icon getFav(bool toggle) {
    return toggle ? Icon(Icons.favorite, size: 40) : Icon(Icons.favorite_border, size: 40);
  }

  void toggleFav(){
    widget.true_or_false ? Icon(Icons.favorite, size: 40) : Icon(Icons.favorite_border, size: 40);
    widget.true_or_false = !widget.true_or_false;
  }

}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/network/network_request.dart';

class FavoriteIcon extends StatefulWidget {

  bool true_or_false;
  FavoriteIcon({required this.true_or_false});

  @override
  _FavoriteIconState createState() => _FavoriteIconState();

}

class _FavoriteIconState extends State<FavoriteIcon>{

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        setState((){
          NetworkRequest.saveFavouriteGame("111");
          widget.true_or_false ? Icon(Icons.favorite) : Icon(Icons.favorite_border);
          widget.true_or_false = !widget.true_or_false;
        });
      },
      child: getFav(widget.true_or_false)
    );
  }

  Icon getFav(bool toggle) {
    return toggle ? Icon(Icons.favorite) : Icon(Icons.favorite_border);
  }

}
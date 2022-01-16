import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget{
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Text(
        'Favorite',
        style: TextStyle(
          fontSize: 60,
          color: Colors.indigoAccent,
        ),
      )
    ),
  );
}
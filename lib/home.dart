import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Text(
        'Home',
        style: TextStyle(
          fontSize: 60,
          color: Colors.indigoAccent,
        ),
      )
    ),
  );
}
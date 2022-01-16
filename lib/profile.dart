import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Text(
        'Profile',
        style: TextStyle(
          fontSize: 60,
          color: Colors.indigoAccent,
        ),
      )
    ),
  );
}
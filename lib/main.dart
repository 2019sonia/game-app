import 'package:flutter/material.dart';
import 'package:untitled/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'nav_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GamesApp());
}

class GamesApp extends StatelessWidget{
  const GamesApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Game App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: NavController( title: 'home',),
    );
  }
}

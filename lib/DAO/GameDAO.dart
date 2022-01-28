import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class GameDAO {
  static final DatabaseReference _gamesRef =
  FirebaseDatabase.instance.reference().child('users').child(
      FirebaseAuth.instance.currentUser?.uid ?? "failed");

  void saveGame(String id) {
    _gamesRef.child(id).set(id);
  }

  void deleteGame(String id) {
    _gamesRef.child(id).remove();
  }

  static Future<DataSnapshot> getData(){
    return _gamesRef.once();
  }
}
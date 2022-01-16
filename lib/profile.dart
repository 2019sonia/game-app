import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/login.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();

}

  class ProfilePageState extends State<ProfilePage> {
    FirebaseAuth auth = FirebaseAuth.instance;
    signOut() async {
      await auth.signOut();
    }
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Container(
          child: TextButton(
            onPressed: () {
              signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()
                  )
              );
            },
            child: Text('Sign Out'),

          )
      ),
    ),
  );
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
            children:
            [
              Container(
                width: width,
                height: 0.7 * height,
                child:
                Lottie.network('https://assets2.lottiefiles.com/private_files/lf30_um4sz3z5.json'),
              ),
              TextButton(
                onPressed: () {
                  signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()
                      )
                  );
                },
                child: Container(
                width: width,
                height: 0.1*height,
                margin: const EdgeInsets.only(left:80, right: 80),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(120.0),
                      bottomLeft: Radius.circular(120.0),
                      topRight: Radius.circular(120.0),
                      topLeft: Radius.circular(120.0)),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                      "Sign out",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color:Colors.white,
                      )
                  ),
                ),
              ),
              )
            ]
        ),
      ),
    );
  }
}
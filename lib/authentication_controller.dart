import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/home.dart';
import 'package:untitled/login.dart';

class AuthenticationController extends GetxController{
  static AuthenticationController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  
  @override
  void onRead(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser); //get current user
    _user.bindStream(auth.userChanges()) ; //keep track of log in and sign out
    ever(_user, _initScreen); //_user is a listener and _init is a callback func
  }
  
  _initScreen(User? user){
    if(user==null){
      print("Login page");
      Get.offAll(()=>LoginPage());
    }else{
      Get.offAll(()=>HomePage());
    }
  }
  void logout() async {
    await auth.signOut();
  }

  void login(String email, password) async {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      Get.snackbar("About login", "Login message",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black54,
          titleText: Text(
            "Login failed",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
    }

  }

  void register(String email, password) async {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }catch(e){
      Get.snackbar("About user", "User message",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black54,
        titleText: Text(
          "Account creation failed",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white
          ),
        )
      );
    }
    
  }
}
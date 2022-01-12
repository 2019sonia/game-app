import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/signup.dart';

import 'home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);


 final FirebaseAuth _firebase =  FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: 0.25*height,
                child: Column(
                  children: [
                    SizedBox(height: height*0.05),
                    CircleAvatar(
                        radius: height*0.1,
                      backgroundImage: AssetImage(
                          "assets/logo.png"
                      ),
                      ),

                  ],
                )

            ),
            Container(
              width: width,
              margin: const EdgeInsets.only(left:40, right: 40),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40,),
                    Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(120.0), color:Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            offset: Offset(1,1),
                            spreadRadius: 3,
                            color: Colors.grey.withOpacity(0.4)
                          ),
                        ]
                      ),
                      child: TextField(
                          controller: emailController,
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email, color:Colors.teal),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60),
                            borderSide: BorderSide(
                              color: Colors.white
                            )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60),
                              borderSide: BorderSide(
                                  color: Colors.white
                              )
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(120.0),
                          )
                        )
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(120.0), color:Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                offset: Offset(1,1),
                                spreadRadius: 3,
                                color: Colors.grey.withOpacity(0.4)
                            ),
                          ]
                      ),
                      child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(Icons.password, color:Colors.teal),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(120.0),
                              )
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              )
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                try {
                  await _firebase.signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim()
                  );
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(),
                    ),
                  );
                }on FirebaseAuthException catch (e){
                  showDialog(
                    context: context,
                    builder: (cx) => AlertDialog(
                      title: Text("Invalid login"),
                      content: Text('${e.message}'),
                    )
                  );
                }
              },
              child: Container(
                  width: width,
                  height: height*0.1,
                  margin: const EdgeInsets.only(left:80, right: 80),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(120.0),
                        bottomLeft: Radius.circular(120.0),
                        topRight: Radius.circular(120.0),
                        topLeft: Radius.circular(120.0)),
                    color: Colors.teal,
                  ),
                child: Center(
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color:Colors.white,
                    )
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(
                    text: "Not on this app yet?",
                    style:  TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                      text: " Sign up",
                      style:  TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage())
                      )
                    ]
            )
            )
          ],
        ),
      ),
      );
  }
}

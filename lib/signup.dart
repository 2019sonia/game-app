import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                width: width,
                height: 0.25*height,
              child: Column(
                children: [
                  SizedBox(height: height*0.2),
                  const Expanded(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage(
                        "assets/profile.png"
                      ),
                    ),
                  )
                ],
              )

            ),
            Container(
                width: width,
                margin: const EdgeInsets.only(left:40, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40,),
                    Text(
                      "Welcome!",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Sign up",
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
                  ],
                )
            ),
            SizedBox(
              height: 20,
            ),
            Container(
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
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color:Colors.white,
                    )
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(text: const TextSpan(
                text: "Already have an account?",
                style:  TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: " Log in",
                    style:  TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ]
            ))
          ],
        )
    );
  }
}

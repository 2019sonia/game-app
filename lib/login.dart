import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/logo.png'),
                    scale: 0.3
              ),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(120.0),
                  bottomLeft: Radius.circular(120.0)),
              color: Colors.teal,

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
                  "Hi!",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Log in",
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
                Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
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
                "Log in",
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
              )
            ]
          ))
        ],
      )
    );
  }
}

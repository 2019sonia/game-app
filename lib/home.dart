import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                      "Home page",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                )
            ),

          ],
        )
    );
  }
}

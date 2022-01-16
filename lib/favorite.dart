import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritePage extends StatelessWidget{
  FavoritePage({Key? key}) : super(key: key);
  final numbers = List.generate(100, (index) => '$index');
  @override
  Widget build(BuildContext context){

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.all(14.0),
                  child: Text(
                    "My favorites",

                    style:GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: buildGridView(),

                )
              ],
            )
        )
    );
  }

  Widget buildGridView() => GridView.builder(
    itemCount: numbers.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
    ),
    itemBuilder: (BuildContext context, int index) { //creates every item individually
      return buildGame('game name', index.toString());
    },

  );

  Widget buildGame(String name, String number) => Card(
      color: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image:NetworkImage('https://play-lh.googleusercontent.com/V-lvUzA5kK0Xw3wdg8Ct3vfIMXUX5vXYcNLPmudaZ-eyQjedYz-luqIuLmJO6KodE0Y'),
            fit: BoxFit.cover,
          ),
        ),

        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              '\$00.00',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                backgroundColor: Colors.white.withOpacity(0.8),
              ),
            ),
          ),

        ),
      )
  );

}

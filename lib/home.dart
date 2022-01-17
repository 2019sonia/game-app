import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget{
  HomePage({Key? key}) : super(key: key);
  final numbers = List.generate(100, (index) => '$index');

  @override
  Widget build(BuildContext context){

    return Scaffold(
    backgroundColor: Colors.white,
        appBar: AppBar( // TODO: Feel free to delete it and replace it with another search bar
          title: Text("Search"),
          actions: [
            IconButton(
                onPressed: (){
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
                icon: const Icon(Icons.search))
          ],
        ),
    body: Container(
      child: Column(
        children: [
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
      return buildGame('game name', index.toString(), context); //TODO: Change parameters as needed, maybe create game object?
    },

  );

  Widget buildGame(String name, String number, BuildContext context ) => Card(
    color: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    child: GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage( //TODO: Change game image (line below)
            image:NetworkImage('https://play-lh.googleusercontent.com/V-lvUzA5kK0Xw3wdg8Ct3vfIMXUX5vXYcNLPmudaZ-eyQjedYz-luqIuLmJO6KodE0Y'),
            fit: BoxFit.cover,
          ),
        ),

        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              '\$00.00', // TODO: Change price name
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  backgroundColor: Colors.white.withOpacity(0.8),
              ),
            ),
          ),

        ),
      ),
      onTap: () {
        showGameInfo(context);
      }
    ),
  );

  showGameInfo(BuildContext context) { //TODO: Change parameters as needed, maybe pass Game object (which need to be created)
    return showDialog(
        context: context,
        builder: (context){
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width*0.7,
                height: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'assets/logo.png', width: 120, height: 120, //TODO: Change game image
                        fit: BoxFit.cover,),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "Game", //TODO: Change game name
                      style: TextStyle(
                        fontSize: 35,
                        color:Colors.grey,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    SizedBox(height: 10,),

                    Text(
                      "price, store, url?", //TODO: Change game details
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    IconButton(
                      icon: Icon(Icons.favorite), //TODO: Filled/Not filled heart depending if it's a favortie or not
                      color: Colors.red,
                      iconSize: 45,
                      onPressed: () {}, //TODO: Add as favourite / Delete from favorites in the Firebase DB
                    ),
                  ],
                )
              ),
            ),
          );
        }
    );
  }

}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget{
  HomePage({Key? key}) : super(key: key);
  final numbers = List.generate(100, (index) => '$index');

  @override
  Widget build(BuildContext context){

    return Scaffold(
    backgroundColor: Colors.white,
        appBar: AppBar(
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
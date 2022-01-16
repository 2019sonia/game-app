import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/profile.dart';

import 'favorite.dart';
import 'home.dart';
class NavController extends StatefulWidget {
  const NavController({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<NavController> createState() => NavControllerState();
}

class NavControllerState extends State<NavController> {
  final items = <StatelessWidget>[
    Icon(Icons.home, size: 40),
    Icon(Icons.favorite, size:40),
    Icon(Icons.person, size:40),
  ];

  final screens = [
    HomePage(),
    FavoritePage(),
    ProfilePage(),
  ];

  int index = 0;

  void changeIndex(int index) {
    setState(() {
      this.index = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        extendBody: true, //for elements to appear behind nav selected element
        backgroundColor: Colors.white,
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.indigoAccent,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          index: index,
          items: items,
          animationDuration: Duration(milliseconds: 250),
          onTap: (index) => changeIndex(index)
        ),
        body: screens[index],
    );
  }


}

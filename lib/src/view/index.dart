import 'dart:async';

import 'package:NoEstasSola/src/view/mapaPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _page = 1;
  Widget pageCurrent = MapaPage();
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double heigth=MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 1,
          height: 50.0,
          items: <Widget>[
            Icon(
              Icons.chat_bubble_rounded,
              size: 30,
              color: Color.fromRGBO(102, 51, 204, 1),
            ),
            Icon(Icons.directions_car_rounded,
                size: 30, color: Color.fromRGBO(102, 51, 204, 1)),
            Icon(Icons.warning_rounded,
                size: 30, color: Color.fromRGBO(102, 51, 204, 1)),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Color.fromRGBO(207, 197, 239, 1),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              switch (index) {
                case 0:
                  pageCurrent = Container();
                  break;
                case 1:
                  pageCurrent = MapaPage();
                  break;
                case 2:
                  pageCurrent = Container();
                  break;
              }
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
            color: Color.fromRGBO(207, 197, 239, 1), child: pageCurrent),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: Container(
            width: width/2,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,

              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(207, 197, 239, 1),
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

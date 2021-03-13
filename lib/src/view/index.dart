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
Widget pageCurrent=MapaPage();
  GlobalKey _bottomNavigationKey = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 1,
          height: 50.0,
          items: <Widget>[
          
            Icon(Icons.chat_bubble_rounded, size: 30,
            color: Color.fromRGBO(102, 51, 204, 1),),
            Icon(Icons.directions_car_rounded, size: 30,
            color: Color.fromRGBO(102, 51, 204, 1)),
            Icon(Icons.warning_rounded, size: 30,
            color: Color.fromRGBO(102, 51, 204, 1)),
            
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
                 pageCurrent=Container();
                 break;
               case 1:
               pageCurrent=MapaPage();
               break;
               case 2:
               pageCurrent=Container();
               break;
               
             }
             _page=index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Color.fromRGBO(207, 197, 239, 1),
          
            child: pageCurrent
         
        ));
  }

 
}

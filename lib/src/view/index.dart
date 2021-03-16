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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
          child: const Icon(
            Icons.people,
            color: Color.fromRGBO(102, 51, 204, 1),
          ),
          backgroundColor: Colors.transparent,
        ),
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
        endDrawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: Container(
            width: width / 2,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,

              children: <Widget>[
                DrawerHeader(
                  child: Text(
                    'Nombre de usuaria',
                    style: TextStyle(
                      color: Color.fromRGBO(40, 1, 102, 1),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(207, 197, 239, 1),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: heigth / 20,
                      child: Icon(
                        Icons.volunteer_activism,
                        color: Color.fromRGBO(40, 1, 102, 1),
                      ),
                    ),
                    Container(
                      height: heigth / 15,
                      width: width / 2,
                      child: ListTile(
                        title: Text(
                          'Contacto de confianza',
                          style:
                              TextStyle(color: Color.fromRGBO(101, 79, 168, 1)),
                        ),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: heigth / 20,
                      child: Icon(
                        Icons.chat_rounded,
                        color: Color.fromRGBO(40, 1, 102, 1),
                      ),
                    ),
                    Container(
                      height: heigth / 15,
                      width: width / 2,
                      child: ListTile(
                        title: Text(
                          'Mensajes',
                          style:
                              TextStyle(color: Color.fromRGBO(101, 79, 168, 1)),
                        ),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: heigth / 20,
                      child: Icon(
                        Icons.watch_later_outlined,
                        color: Color.fromRGBO(40, 1, 102, 1),
                      ),
                    ),
                    Container(
                      height: heigth / 15,
                      width: width / 2,
                      child: ListTile(
                        title: Text(
                          'Historial de viajes',
                          style:
                              TextStyle(color: Color.fromRGBO(101, 79, 168, 1)),
                        ),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: heigth / 20,
                      child: Icon(
                        Icons.credit_card,
                        color: Color.fromRGBO(40, 1, 102, 1),
                      ),
                    ),
                    Container(
                      height: heigth / 15,
                      width: width / 2,
                      child: ListTile(
                        title: Text(
                          'Metodos de pago',
                          style:
                              TextStyle(color: Color.fromRGBO(101, 79, 168, 1)),
                        ),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: heigth / 20,
                      child: Icon(
                        Icons.settings,
                        color: Color.fromRGBO(40, 1, 102, 1),
                      ),
                    ),
                    Container(
                      height: heigth / 15,
                      width: width / 2,
                      child: ListTile(
                        title: Text(
                          'Configuracion',
                          style:
                              TextStyle(color: Color.fromRGBO(101, 79, 168, 1)),
                        ),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: heigth / 20,
                      child: Icon(
                        Icons.live_help_outlined,
                        color: Color.fromRGBO(40, 1, 102, 1),
                      ),
                    ),
                    Container(
                      height: heigth / 15,
                      width: width / 2,
                      child: ListTile(
                        title: Text(
                          'Ayuda',
                          style:
                              TextStyle(color: Color.fromRGBO(101, 79, 168, 1)),
                        ),
                        onTap: () {
                          // Update the state of the app
                          // ...
                          // Then close the drawer
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class Seguridad extends StatefulWidget {
  Seguridad({Key key}) : super(key: key);

  @override
  _SeguridadState createState() => _SeguridadState();
}

class _SeguridadState extends State<Seguridad> {
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: height / 13),
                    child: Center(
                      child: Text(
                        'Seguridad',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: height / 20,
                            color: Color.fromRGBO(101, 79, 168, 1),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(top: height / 25, right: width / 3),
                        child: Text(
                          'Mis Herramientas de seguridad',
                          style: TextStyle(
                            color: Color.fromRGBO(101, 79, 168, 1),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: height / 15, right: width / 2.1),
                        child: Text(
                          'Contactos de confianza',
                          style: TextStyle(
                            color: Color.fromRGBO(101, 79, 168, 1),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: height / 15, right: width / 1.55),
                        child: Text(
                          'Mi ubicación',
                          style: TextStyle(
                            color: Color.fromRGBO(101, 79, 168, 1),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: height / 15, right: width / 2.5),
                        child: Text(
                          'Reconocimiento biometrico',
                          style: TextStyle(
                            color: Color.fromRGBO(101, 79, 168, 1),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: height / 15, right: width / 1.7),
                        child: Text(
                          'Botón de pánico',
                          style: TextStyle(
                            color: Color.fromRGBO(101, 79, 168, 1),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: height / 15, right: width / 2.5),
                        child: Text(
                          'Prótocolos de bioseguridad',
                          style: TextStyle(
                            color: Color.fromRGBO(101, 79, 168, 1),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

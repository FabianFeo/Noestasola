import 'package:NoEstasSola/src/view/chat.dart';
import 'package:NoEstasSola/src/view/mensajeria.dart';
import 'package:flutter/material.dart';

class MensajesUser extends StatefulWidget {
  MensajesUser({Key key}) : super(key: key);

  @override
  _MensajesUserState createState() => _MensajesUserState();
}

class _MensajesUserState extends State<MensajesUser> {
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: height / 2),
              child: Image(
                image: AssetImage('assets/Logo/lu_back.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height / 25),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: height / 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Center(
                          child: Text(
                            //mensajes de publicidad y de la aplicacion
                            'Mensajes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: height / 20,
                                color: Color.fromRGBO(101, 79, 168, 1),
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    height: height / 10,
                    width: width / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Color.fromRGBO(101, 79, 168, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: height / 25, left: width / 18),
                              child: Text(
                                //todos los mensajes recibidos
                                'Todos los mensajes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: height / 25, right: width / 20),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Mensajeria()));
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height / 20),
                    height: height / 10,
                    width: width / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Color.fromRGBO(101, 79, 168, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: height / 25, left: width / 18),
                              child: Text(
                                //mensajes para la ubicacion y la comunicacion con los servicios
                                'Mensajes usuaria / conductora',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: height / 25, right: width / 20),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Chat()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height / 20),
                    height: height / 10,
                    width: width / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Color.fromRGBO(101, 79, 168, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: height / 25, left: width / 18),
                              child: Text(
                                //mensajes que he enviado
                                'Mensajes Lu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: height / 25, right: width / 20),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

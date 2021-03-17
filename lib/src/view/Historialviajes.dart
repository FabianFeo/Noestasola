import 'package:flutter/material.dart';

class HistorialViajes extends StatefulWidget {
  HistorialViajes({Key key}) : super(key: key);

  @override
  _HistorialViajesState createState() => _HistorialViajesState();
}

class _HistorialViajesState extends State<HistorialViajes> {
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(207, 197, 239, 1),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: height / 13),
                child: Center(
                    child: Text(
                  'Tus Viajes',
                  style: TextStyle(
                      fontSize: height / 20,
                      color: Color.fromRGBO(40, 1, 102, 1),
                      fontWeight: FontWeight.w500),
                )),
              ),
              Card(
                color: Color.fromRGBO(40, 1, 102, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.purple),
                ),
                margin: EdgeInsets.all(30),
                child: Container(
                  height: height / 6,
                  child: Row(
                    children: [
                      Container(
                        width: width / 2,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: height / 40, left: width / 19),
                              width: width / 1.5,
                              child: Text(
                                'Fecha',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: height / 40, left: width / 19),
                              width: width / 1.5,
                              child: Text(
                                'Origen',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: height / 40, left: width / 19),
                              width: width / 1.5,
                              child: Text(
                                'Destino',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          'Valor',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:NoEstasSola/src/view/Inicio.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

class ScannerRostro extends StatefulWidget {
  ScannerRostro({Key key}) : super(key: key);

  @override
  _ScannerRostroState createState() => _ScannerRostroState();
}

class _ScannerRostroState extends State<ScannerRostro> {
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(229, 255, 255, 1),
        body: Container(
          margin: EdgeInsets.only(top: height / 8),
          child: Column(
            children: [
              Container(
                  child: Center(
                child: Text(
                  'Escaneo Facial',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromRGBO(101, 79, 168, 1)),
                ),
              )),
              Container(
                  margin: EdgeInsets.all(40),
                  child: Center(
                    child: Text(
                      'Por favor escanea tu rostro para finalizar con el proceso de registro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(101, 79, 168, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                  )),
                  Container(
                  margin: EdgeInsets.all(40),
                  child: Center(
                    child: Text(
                      'AQUI VA EL ESCANER DE ROSTRO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(101, 79, 168, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 60,
                      ),
                    ),
                  )),
              BouncingWidget(
                  duration: Duration(milliseconds: 100),
                  scaleFactor: 1.5,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Inicio()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    color: Color.fromRGBO(101, 79, 168, 1),
                    child: Container(
                      width: width / 2,
                      height: height / 20,
                      child: Text(
                        "Finalizar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

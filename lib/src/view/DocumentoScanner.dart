import 'package:NoEstasSola/src/view/ScannerCara.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

class DocumentoScanner extends StatefulWidget {
  DocumentoScanner({Key key}) : super(key: key);

  @override
  _DocumentoScannerState createState() => _DocumentoScannerState();
}

class _DocumentoScannerState extends State<DocumentoScanner> {
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Text(
                      'Ingreso Scanner',
                      style: TextStyle(
                          fontSize: 22, color: Color.fromRGBO(101, 79, 168, 1)),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(40),
                    child: Center(
                      child: Text(
                        'Por favor escanea tu documento de forma que sea visible el numero y la fecha de expedición',
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
                      'Aqui va el escaner',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
                BouncingWidget(
                    duration: Duration(milliseconds: 100),
                    scaleFactor: 1.5,
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScannerRostro()),
                          );
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
                          "Verificar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

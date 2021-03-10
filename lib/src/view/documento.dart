import 'dart:ffi';

import 'package:NoEstasSola/src/view/DocumentoManual.dart';
import 'package:NoEstasSola/src/view/DocumentoScanner.dart';
import 'package:flutter/material.dart';

class Documento extends StatefulWidget {
  Documento({Key key}) : super(key: key);

  @override
  _DocumentoState createState() => _DocumentoState();
}

class _DocumentoState extends State<Documento> {
  double height = 0;
  double width = 0;

  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

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
                      'Tipo de Documento',
                      style: TextStyle(
                          fontSize: 22, color: Color.fromRGBO(101, 79, 168, 1)),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(40),
                    child: Center(
                      child: Text(
                        'Por favor selecciona tu tipo de documento y la forma en la que quieres registrarlo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(101, 79, 168, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: selectedRadio,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio(val);
                      },
                    ),
                    Text('C.C'),
                    Radio(
                      value: 2,
                      groupValue: selectedRadio,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio(val);
                      },
                    ),
                    Text('C.E')
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: height / 10),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentoManual()),
                          )
                        },
                        child: SizedBox(
                          width: width / 2,
                          child: Container(
                              alignment: Alignment.center,
                              height: height / 9,
                              width: width / 9,
                              decoration: new BoxDecoration(
                                color: Color.fromRGBO(101, 79, 168, 1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "Manual",
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: 12),
                                ),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentoScanner()),
                          )
                        },
                        child: SizedBox(
                          width: width / 2,
                          child: Container(
                              alignment: Alignment.center,
                              height: height / 9,
                              width: width / 9,
                              decoration: new BoxDecoration(
                                color: Color.fromRGBO(101, 79, 168, 1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "Escanear",
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: 12),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

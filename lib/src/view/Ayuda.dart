import 'package:flutter/material.dart';

class Ayuda extends StatefulWidget {
  Ayuda({Key key}) : super(key: key);

  @override
  _AyudaState createState() => _AyudaState();
}

class _AyudaState extends State<Ayuda> {
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
                        'Ayuda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: height / 20,
                            color: Color.fromRGBO(101, 79, 168, 1),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

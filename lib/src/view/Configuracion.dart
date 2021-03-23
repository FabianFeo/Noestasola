import 'package:flutter/material.dart';

class Config extends StatefulWidget {
  Config({Key key}) : super(key: key);

  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
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
           child: SingleChildScrollView(
             child: Container(
               child: Column(
                 children: [
                   Container(
                margin: EdgeInsets.only(top: height / 13),
                child: Center(
                    child: Text(
                  'Configuración',
                  style: TextStyle(
                      fontSize: height / 20,
                      color: Color.fromRGBO(40, 1, 102, 1),
                      fontWeight: FontWeight.w500),
                )),
              ),
              Container(
                child: Container(),
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
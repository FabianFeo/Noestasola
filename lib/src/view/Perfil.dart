import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  Perfil({Key key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
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
                  'Mi perfil',
                  style: TextStyle(
                      fontSize: height / 20,
                      color: Color.fromRGBO(40, 1, 102, 1),
                      fontWeight: FontWeight.w500),
                )),
               ), 
             ],
           ),
         ),

       ),
    );
  }
}
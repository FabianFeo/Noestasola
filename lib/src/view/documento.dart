import 'package:flutter/material.dart';

class Documento extends StatefulWidget {
  Documento({Key key}) : super(key: key);

  @override
  _DocumentoState createState() => _DocumentoState();
}

class _DocumentoState extends State<Documento> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         backgroundColor: Color.fromRGBO(229, 255, 255, 1),
       ),
    );
  }
}
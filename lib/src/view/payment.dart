import 'package:flutter/material.dart';

class Pagos extends StatefulWidget {
  Pagos({Key key}) : super(key: key);

  @override
  _PagosState createState() => _PagosState();
}

class _PagosState extends State<Pagos> {
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
          margin: EdgeInsets.only(top: height / 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Text(
                    'Metodos de pago',                    
                    style: TextStyle(
                        fontSize: height / 20,
                        color: Color.fromRGBO(40, 1, 102, 1),
                        fontWeight: FontWeight.w500),
                  ),
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
                  color: Color.fromRGBO(50, 31, 106, 0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        'Agregar tu metodo de pago',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        child: Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white,),
                      onTap: () {},
                      ),
                    ),                    
                  ],
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

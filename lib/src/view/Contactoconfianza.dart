import 'package:flutter/material.dart';

class ContactoConfianza extends StatefulWidget {
  ContactoConfianza({Key key}) : super(key: key);

  @override
  _ContactoConfianzaState createState() => _ContactoConfianzaState();
}

class _ContactoConfianzaState extends State<ContactoConfianza> {
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
                    'Contactos de confianza',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: height / 20,
                        color: Color.fromRGBO(40, 1, 102, 1),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),                  
                ),
                margin: EdgeInsets.all(30),
                child: Container(
                  height: height / 5,
                  child: Center(
                    child: Row(                      
                      children: [
                        Container(
                          width: width / 1.5,
                          child: Text(
                          '¡Aún no tienes un contacto de confianza, añadelo para compartir tu viaje y tu ruta!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        ),
                        Container(
                          width: width - (width / 1.2),
                          child: Icon(Icons.library_add,
                          color: Colors.white,),
                        ),
                        
                      ],
                    ),
                  ),
                ),
                color: Color.fromRGBO(50, 31, 106, 0.3),
              ),
              Container(
                child: Icon(Icons.library_add,
                color: Color.fromRGBO(40, 1, 102, 1),
                size: height / 15,),
              ),
              Container(
                margin: EdgeInsets.only(top: height / 5),
                child: Image.asset('assets/Logo/Lu_logo.png',
                height: height / 5,)
              ),
              

            ],
          ),
        ),
      ),
    );
  }
}

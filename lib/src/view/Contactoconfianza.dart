import 'package:NoEstasSola/src/service/contactosService.dart';
import 'package:NoEstasSola/src/view/FormularioConfianza.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactoConfianza extends StatefulWidget {
  ContactoConfianza({Key key}) : super(key: key);

  @override
  _ContactoConfianzaState createState() => _ContactoConfianzaState();
}

class _ContactoConfianzaState extends State<ContactoConfianza> {
  double height = 0;
  double width = 0;
  var mostrarPlus = true;
  ContactosService _contactosService = ContactosService();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                        StreamBuilder(
                            stream:
                                _contactosService.getEmergenciContactsStream(),
                            builder:
                                (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                            
                              return snapshot.hasData
                                  ? Container(
                                      height: height / 2,
                                      width: width / 1.5,
                                      child: ListView.builder(
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (_, index) {
                                            return Container(
                                              width: width / 1.5,
                                              child: Text(
                                                '${snapshot.data.docs[index].data()["nombre"]}  ${snapshot.data.docs[index].data()["telefono"]}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  : Container(
                                      width: width / 1.5,
                                      child: Text(
                                        '¡Aún no tienes un contacto de confianza, añadelo para compartir tu viaje y tu ruta!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                            }),
                        mostrarPlus
                            ? Container(
                                width: width - (width / 1.2),
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.library_add,
                                    color: Colors.white,
                                  ),
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FormularioConfianza()),
                                    )
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                color: Color.fromRGBO(50, 31, 106, 0.3),
              ),
              Container(
                child: GestureDetector(
                  child: Icon(
                    Icons.library_add,
                    color: Color.fromRGBO(40, 1, 102, 1),
                    size: height / 15,
                  ),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormularioConfianza()),
                    )
                  },
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: height / 5),
                  child: Image.asset(
                    'assets/Logo/Lu_logo.png',
                    height: height / 5,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

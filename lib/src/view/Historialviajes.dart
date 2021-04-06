import 'package:NoEstasSola/src/service/viajeServicecollection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistorialViajes extends StatefulWidget {
  HistorialViajes({Key key}) : super(key: key);

  @override
  _HistorialViajesState createState() => _HistorialViajesState();
}

class _HistorialViajesState extends State<HistorialViajes> {
  ViajesServiceCollection _viajesServiceCollection = ViajesServiceCollection();
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: height / 2),
              child: Image(
                image: AssetImage('assets/Logo/lu_back.png'),
              ),
            ),
            Container(
              height: height,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: height / 13),
                    child: Center(
                        child: Text(
                      'Tus Viajes',
                      style: TextStyle(
                          fontSize: height / 20,
                          color: Color.fromRGBO(101, 79, 168, 1),
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                  StreamBuilder(
                      stream: _viajesServiceCollection.getHistorialViaje(),
                      builder: (_, AsyncSnapshot<QuerySnapshot> response) {
                        return response.hasData
                            ? Center(
                                child: SingleChildScrollView(
                                    child: Container(
                                        height: height*0.8 ,
                                        width: width ,
                                        child: ListView.builder(
                                          itemCount: response.data.docs.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Card(
                                              color: Color.fromRGBO(
                                                  101, 79, 168, 1),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              margin: EdgeInsets.all(30),
                                              child: Container(
                                                height: height / 3.5,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: width / 2,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top:
                                                                        height /
                                                                            40,
                                                                    left:
                                                                        width /
                                                                            19),
                                                            width: width / 1.5,
                                                            child: Text(
                                                              'Fecha: ${response.data.docs[index].data()["date"].toString().split("T")[0]}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top:
                                                                        height /
                                                                            40,
                                                                    left:
                                                                        width /
                                                                            19),
                                                            width: width / 1.5,
                                                            child: Text(
                                                              'Origen: ${response.data.docs[index].data()["direccionInicio"].toString()}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top:
                                                                        height /
                                                                            40,
                                                                    left:
                                                                        width /
                                                                            19),
                                                            width: width / 1.5,
                                                            child: Text(
                                                              'Destino: ${response.data.docs[index].data()["direccionDestino"].toString()}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        'Valor: ${response.data.docs[index].data()["valor"].toString()}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ))))
                            : CircularProgressIndicator();
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

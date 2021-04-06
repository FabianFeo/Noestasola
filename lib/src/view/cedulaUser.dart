import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:NoEstasSola/src/model/document.model.dart';
import 'package:NoEstasSola/src/view/cedulaCarga.dart';

import 'scannerCara.dart';

class DocumentosDriver extends StatefulWidget {
  DocumentosDriver({Key key}) : super(key: key);

  @override
  _DocumentosDriverState createState() => _DocumentosDriverState();
}

List<Documents> documentos = [
  Documents(
    'documento de identificacion',
    'cedula de ciudadania o extrangeria',
  )
];

class _DocumentosDriverState extends State<DocumentosDriver> {
  double height = 0;
  double width = 0;
  List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  _startUp() async {
    cameras = await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.only(top: height / 18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Text(
                      'Documentos de la conductora',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: height / 20,
                        color: Color.fromRGBO(40, 1, 102, 1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                    height: height / 6,
                    child: Center(
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
                            child: Image.asset(
                              'assets/Logo/Conductora.png',
                              height: height / 11.5,
                            ),
                          )),
                    ))),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'Por favor ingresa una foto o archivo de los siguietes documentos, para completar tu registro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(40, 1, 102, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: height / 50,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height / 2.5,
                  width: width,
                  margin: EdgeInsets.all(20),
                  child: Center(
                    child: ListView.builder(
                      itemCount: documentos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              switch (index) {
                                case 0:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CedulaDriver()));
                                  break;
                              }
                            });
                          },
                          title: Text(
                            documentos[index].nombreDocumento,
                            style: TextStyle(
                              color: Color.fromRGBO(40, 1, 102, 1),
                            ),
                          ),
                          subtitle:
                              Text(documentos[index].descripcionDocumento),
                          trailing: Icon(Icons.arrow_forward_ios),
                        );
                      },
                    ),
                  ),
                ),
                BouncingWidget(
                    duration: Duration(milliseconds: 100),
                    scaleFactor: 1.5,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScannerRostro(
                                    cameraDescription: cameras.firstWhere(
                                      (CameraDescription camera) =>
                                          camera.lensDirection ==
                                          CameraLensDirection.front,
                                    ),
                                  )));
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
                          "Continuar",
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

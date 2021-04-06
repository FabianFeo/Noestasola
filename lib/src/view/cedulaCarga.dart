import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:NoEstasSola/src/service/storageFirebaseService.dart';

class CedulaDriver extends StatefulWidget {
  CedulaDriver({Key key}) : super(key: key);

  @override
  _CedulaDriverState createState() => _CedulaDriverState();
}

class _CedulaDriverState extends State<CedulaDriver> {
  PickedFile licenceImage;
  PickedFile licenceImage2;
  var storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: height,
          width: width,
          child: ListView(
            children: <Widget>[imagen()],
          ),
        ),
      ),
    );
  }

  Widget imagen() {
    return Center(
      child: SingleChildScrollView(
          child: Container(
        height: height / 1.2,
        width: width,
        child: Column(
          children: <Widget>[
            Text(
              'Cedula cara posterior.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(101, 79, 168, 1),
                fontWeight: FontWeight.w400,
                fontSize: height / 35,
              ),
            ),
            Center(
                child: Container(
              width: width / 2,
              height: height / 3,
              child: Image(
                image: licenceImage == null
                    ? AssetImage('assets/Logo/Conductora.png')
                    : FileImage(File(licenceImage.path)),
              ),
            )),
            Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => botonFoto()));
                },
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: Color.fromRGBO(101, 79, 168, 1),
                  size: 28,
                ),
              ),
            ),
            Text(
              'Cedula cara trasera.',
              style: TextStyle(
                color: Color.fromRGBO(101, 79, 168, 1),
                fontWeight: FontWeight.w400,
                fontSize: height / 35,
              ),
            ),
            Center(
                child: Container(
              width: width / 2,
              height: height / 3,
              child: Image(
                image: licenceImage2 == null
                    ? AssetImage('assets/Logo/Conductora.png')
                    : FileImage(File(licenceImage2.path)),
              ),
            )),
            Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => botonFoto2()));
                },
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: Color.fromRGBO(101, 79, 168, 1),
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void tomarFoto(ImageSource source) async {
    final archivo = await picker.getImage(source: source);
    StorageFirebaseService storageFirebaseService = StorageFirebaseService();
    storageFirebaseService.uplodaCedulaFrontal(File(archivo.path));
    setState(() {
      licenceImage = archivo;
    });
  }

  void tomarFoto2(ImageSource source) async {
    final archivo = await picker.getImage(source: source);
    StorageFirebaseService storageFirebaseService = StorageFirebaseService();
    storageFirebaseService.uplodaCedulaTrasera(File(archivo.path));
    setState(() {
      licenceImage2 = archivo;
    });
  }

  Widget botonFoto() {
    return Container(
      color: Color.fromRGBO(207, 197, 239, 1),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Text(
            'Sube tu Cedula',
            style: TextStyle(
              color: Color.fromRGBO(101, 79, 168, 1),
              fontWeight: FontWeight.w400,
              fontSize: height / 50,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.camera,
                  color: Color.fromRGBO(101, 79, 168, 1),
                ),
                onPressed: () {
                  tomarFoto(ImageSource.camera);
                },
                label: Text(
                  'Camara',
                  style: TextStyle(
                    color: Color.fromRGBO(101, 79, 168, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: height / 50,
                  ),
                ),
              ),
              FlatButton.icon(
                icon: Icon(
                  Icons.image,
                  color: Color.fromRGBO(101, 79, 168, 1),
                ),
                onPressed: () {
                  tomarFoto(ImageSource.gallery);
                },
                label: Text(
                  'Galeria',
                  style: TextStyle(
                    color: Color.fromRGBO(101, 79, 168, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: height / 50,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget botonFoto2() {
    return Container(
      color: Color.fromRGBO(207, 197, 239, 1),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Text(
            'Sube tu Cedula',
            style: TextStyle(
              color: Color.fromRGBO(101, 79, 168, 1),
              fontWeight: FontWeight.w400,
              fontSize: height / 50,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.camera,
                  color: Color.fromRGBO(101, 79, 168, 1),
                ),
                onPressed: () {
                  tomarFoto2(ImageSource.camera);
                },
                label: Text(
                  'Camara',
                  style: TextStyle(
                    color: Color.fromRGBO(101, 79, 168, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: height / 50,
                  ),
                ),
              ),
              FlatButton.icon(
                icon: Icon(
                  Icons.image,
                  color: Color.fromRGBO(101, 79, 168, 1),
                ),
                onPressed: () {
                  tomarFoto2(ImageSource.gallery);
                },
                label: Text(
                  'Galeria',
                  style: TextStyle(
                    color: Color.fromRGBO(101, 79, 168, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: height / 50,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

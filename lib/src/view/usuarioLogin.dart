import 'package:NoEstasSola/src/service/authService.dart';
import 'package:NoEstasSola/src/view/codigoverificacion.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

class UsuarioLogin extends StatefulWidget {
  UsuarioLogin({Key key}) : super(key: key);

  @override
  _UsuarioLoginState createState() => _UsuarioLoginState();
}

class _UsuarioLoginState extends State<UsuarioLogin> {
  String inputNumeroTelefono;
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(207, 197, 239, 1),
        body: Container(
          margin: EdgeInsets.only(top: height / 6),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Text(
                    "Ingresa tu número de teléfono",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: height / 30,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(101, 79, 168, 1),),
                  ),
                  margin: EdgeInsets.only(bottom: height / 8),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: height / 8),
                    width: width,
                    child: Row(
                      children: [
                        Center(
                            child: Container(
                          margin: EdgeInsets.only(left: width /6),
                          width: width / 1.5,
                          child: TextField(
                            style: TextStyle(
                              fontSize: height / 30,
                            ),
                            onChanged: (value) => inputNumeroTelefono = value,
                            decoration:
                                InputDecoration(hintText: 'Numero de telefono'),
                          ),
                        ))
                      ],
                    )),
                    Container(
                      child: Center(
                        child: Image.asset('assets/Logo/Usuaria.png',
                        height: height / 5,),
                      ),
                    ),
                Container(
                  margin: EdgeInsets.only(bottom: height / 12),
                  child: BouncingWidget(
                      duration: Duration(milliseconds: 100),
                      scaleFactor: 1.5,
                      onPressed: () {
                        AuthService authService = new AuthService();
                        authService
                            .registerUser(inputNumeroTelefono, context)
                            .then((value) {
                          print(value);
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CodigoVerificacion()));
                        });
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
                            "Verificar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ),
                      )),
                ),               
              ],
            ),
          ))));
  }
}

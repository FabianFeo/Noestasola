import 'dart:async';

import 'package:NoEstasSola/src/service/authService.dart';
import 'package:NoEstasSola/src/view/DatosPersonal.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:bouncing_widget/bouncing_widget.dart';

class CodigoVerificacion extends StatefulWidget {
  CodigoVerificacion({Key key}) : super(key: key);

  @override
  _CodigoVerificacionState createState() => _CodigoVerificacionState();
}

class _CodigoVerificacionState extends State<CodigoVerificacion> {
  double height = 0;
  double width = 0;

  var errorController;

  var textEditingController;

  String currentText;
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
                  'Ingresa tu codigo de seguridad',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: height / 20,
                    color: Color.fromRGBO(40, 1, 102, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
              Container(
                  margin: EdgeInsets.all(40),
                  child: Center(
                    child: Text(
                      'Enviaremos un código de 6 digitos a tu numero de teléfono registrado, para verificar tu identidad',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(40, 1, 102, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: height / 32),
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(22),
                child: PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    inactiveFillColor: Color.fromRGBO(230, 224, 237, 0.5),
                    inactiveColor: Color.fromRGBO(101, 79, 168, 1),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    selectedColor: Color.fromRGBO(101, 79, 168, 1),
                    selectedFillColor: Color.fromRGBO(225, 206, 239, 1),
                    activeColor: Color.fromRGBO(101, 79, 168, 1),
                    activeFillColor: Color.fromRGBO(230, 224, 237, 0.5),
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Color.fromRGBO(207, 197, 239, 1),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
              ),
              Container(
                child: Image.asset(
                  'assets/Logo/Usuaria.png',
                  height: height / 11.5,
                ),
              ),
              BouncingWidget(
                  duration: Duration(milliseconds: 100),
                  scaleFactor: 1.5,
                  onPressed: () {
                    AuthService authService = AuthService();
                    authService.signInWithPhoneNumber(currentText, context);
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
            ],
          ),
        ),
      ),
    ));
  }
}

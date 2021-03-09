import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
        child: Scaffold(
      backgroundColor: Colors.blue[100],
      body: Container(
        margin: EdgeInsets.only(top: height / 4),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: Center(
                child: Text(
                  'Ingresa tu codigo de seguridad',
                  style: TextStyle(fontSize: 22),
                ),
              )),
              Container(
                  margin: EdgeInsets.all(40),
                  child: Center(
                    child: Text(
                        'Enviaremos un código de 6 digitos a tu numero de teléfono registrado, para verificar tu identidad'),
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
                  inactiveFillColor: Colors.white,
                  inactiveColor: Colors.blue[100],
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.blue[100],
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
                }, appContext: context,
              ),
              )    
              
            ],
          ),
        ),
      ),
    ));
  }
}

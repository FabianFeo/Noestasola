import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class Config extends StatefulWidget {
  Config({Key key}) : super(key: key);

  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
       child: Scaffold(
         backgroundColor: Colors.white,
         body: Container(
           child: SingleChildScrollView(
             child: Container(
               child: Column(
                 children: [
                   Container(
                margin: EdgeInsets.only(top: height / 13),
                child: Center(
                    child: Text(
                  'Configuración de privacidad',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: height / 20,
                      color: Color.fromRGBO(101, 79, 168, 1),
                      fontWeight: FontWeight.w500),
                )),
              ),
              Container(
                margin: EdgeInsets.only(top: height / 20),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        'SMS',
                        style: TextStyle(
                          color:Color.fromRGBO(101, 79, 168, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: height / 50, 

                        ),
                      ),
                    ),
                    Container(
                      height: height / 30,
                     width: width / 5,
                      child: LiteRollingSwitch(  
                        animationDuration: Duration(milliseconds: 2),                      
                        value: true,
                        textOn: 'On',
                        textOff: 'off',
                        colorOn: Color.fromRGBO(101, 79, 168, 1),
                        colorOff: Colors.grey,
                        iconOn: Icons.auto_fix_high,
                        iconOff: Icons.auto_fix_off,
                        onChanged: (bool position) {
                          print('el boton es $position');
                        },
                      ),
                    )
                  ],
                )
              )
                 ],
               ),
             ),
           ),
         ),
       ),
    );
  }
}
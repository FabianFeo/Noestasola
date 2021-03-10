import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(229, 255, 255, 1),
        body: Container(
          margin: EdgeInsets.only(top: height / 8),
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Text(
                    'Bienvenida',
                    style: TextStyle(
                        fontSize: 22,
                        color: Color.fromRGBO(101, 79, 168, 1),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              BeautyTextfield(
                width: double.maxFinite, //REQUIRED
                height: 60, //REQUIRED
                accentColor: Colors.white, // On Focus Color
                textColor: Color.fromRGBO(101, 79, 168, 1), //Text Color
                backgroundColor: Colors.white, //Not Focused Color
                textBaseline: TextBaseline.alphabetic,
                autocorrect: false,
                autofocus: false,
                enabled: true, // Textfield enabled
                focusNode: FocusNode(),
                fontFamily: 'Gotham Rounded', //Text Fontfamily
                fontWeight: FontWeight.w500,

                margin: EdgeInsets.all(30),
                cornerRadius: BorderRadius.all(Radius.circular(15)),
                duration: Duration(milliseconds: 300),
                inputType: TextInputType.streetAddress, //REQUIRED
                placeholder: "¿A donde quieres ir?",
                isShadow: true,
                obscureText: false,
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                onChanged: (text) {
                  print(text);
                },
              ),
              Container(
                  margin: EdgeInsets.all(40),
                  child: Center(
                    child: Text(
                      'AQUI VA EL MAPA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(101, 79, 168, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 60,
                      ),
                    ),
                  )),
               Center(
                    child: Container(
                  width: width,
                  child: Row(
                    children: [
                      GestureDetector(
                        child: SizedBox(
                          width: width / 3,
                          child: Container(
                              alignment: Alignment.center,
                              height: height / 9,
                              width: width / 9,
                              decoration: new BoxDecoration(
                                color: Color.fromRGBO(107, 79, 168, 1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text("Pedir Viaje",
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: 16)),
                              )),
                        ),
                        onTap: () => {
                        },
                      ),
                      SizedBox(
                        width: width / 3,
                        child: Container(
                            alignment: Alignment.center,
                            height: height / 9,
                            width: width / 9,
                            decoration: new BoxDecoration(
                              color: Color.fromRGBO(107, 79, 168, 1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text("PANICO",
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: 20)),
                            )),
                      ),
                      SizedBox(
                        width: width / 3,
                        child: Container(
                            alignment: Alignment.center,
                            height: height / 9,
                            width: width / 9,
                            decoration: new BoxDecoration(
                              color: Color.fromRGBO(107, 79, 168, 1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text("Blog",
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: 20)),
                            )),
                      )
                    ],
                  ),
                )),    
            ],
          ),
        ),
      ),
    );
  }
}

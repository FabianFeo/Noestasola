import 'package:NoEstasSola/src/view/index.dart';
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
        backgroundColor: Colors.purple[100],
        body: Container(
          margin: EdgeInsets.only(top: height / 4),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Text("Ingresa tu número de teléfono"),
                  margin: EdgeInsets.only(bottom: height / 8),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: height / 8),
                    width: width,
                    child: Row(
                      children: [
                        Center(
                            child: Container(
                          margin: EdgeInsets.only(left: width / 4),
                          width: width / 1.5,
                          child: TextField(
                            onChanged: (value) => inputNumeroTelefono = value,
                            decoration: InputDecoration(
                                hintText: 'Enter a search term'),
                          ),
                        ))
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: height / 9),
                  child: Text("O ingresa con tus redes sociales"),
                ),
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
                                color: Colors.purple[300],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text("red1"),
                              )),
                        ),
                        onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Index()),
                          )
                        },
                      ),
                      SizedBox(
                        width: width / 3,
                        child: Container(
                            alignment: Alignment.center,
                            height: height / 9,
                            width: width / 9,
                            decoration: new BoxDecoration(
                              color: Colors.purple[300],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text("red2"),
                            )),
                      ),
                      SizedBox(
                        width: width / 3,
                        child: Container(
                            alignment: Alignment.center,
                            height: height / 9,
                            width: width / 9,
                            decoration: new BoxDecoration(
                              color: Colors.purple[300],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text("red3"),
                            )),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

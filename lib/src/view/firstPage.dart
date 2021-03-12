import 'package:NoEstasSola/src/view/ConductoraLogin.dart';
import 'package:NoEstasSola/src/view/usuarioLogin.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
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
          margin: EdgeInsets.only(top: height / 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: height / 8),
                    height: height / 3,
                    width: width / 3,
                    child: Container(
                      child: Image(image: AssetImage('assets/Logo/Logo_lala_app.png'),
                      height: 100,
                      width: 100,),
                    ), ),
                    
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConductoraLogin()),
                          )
                        },
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
                                child:Icon(Icons.car_repair,
                                color: Color.fromRGBO(255, 255, 255, 1),
                                size: 50,), 
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UsuarioLogin()),
                          )
                        },
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
                                child: Icon(Icons.person,
                                color: Color.fromRGBO(255, 255, 255, 1),
                                size: 50,),                                
                              ),),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

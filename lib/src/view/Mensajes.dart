import 'package:flutter/material.dart';

class MensajesUser extends StatefulWidget {
  MensajesUser({Key key}) : super(key: key);

  @override
  _MensajesUserState createState() => _MensajesUserState();
}

class _MensajesUserState extends State<MensajesUser> {
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
          margin: EdgeInsets.only(top: height / 8),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: height / 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email_outlined,
                        color: Color.fromRGBO(40, 1, 102, 1),
                        size: height / 20),
                    Container(
                        child: Center(
                      child: Text(
                        'Mensajes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: height / 20,
                            color: Color.fromRGBO(40, 1, 102, 1),
                            fontWeight: FontWeight.w500),
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                height: height / 10,
                width: width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Color.fromRGBO(50, 31, 106, 0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        'Todos los mensajes',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        child: Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white,),
                      onTap: () {},
                      ),
                    ),                    
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height / 20),
                height: height / 10,
                width: width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Color.fromRGBO(50, 31, 106, 0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        'Mensajes usuaria / conductora',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        child: Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white,),
                      onTap: () {},
                      ),
                    ),                    
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height / 20),
                height: height / 10,
                width: width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Color.fromRGBO(50, 31, 106, 0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        'Mensajes enviados',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        child: Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white,),
                      onTap: () {},
                      ),
                    ),                    
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

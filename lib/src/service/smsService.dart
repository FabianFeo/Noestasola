import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:NoEstasSola/src/model/User.model.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
User _user = User();

void sendSMSCon(String message, List<String> recipents) async {
  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });
  print(_result);
}

whatsappSMS(contactFinal) async {
  int min = 10000;
  int max = 99999;
  var randomizer = new Random();
  var rNum = min + randomizer.nextInt(max - min);


  var message = _user.firstName +
      " nesecita tu ayuda, ingresa a este link con el siguiente codigo: " +
      rNum.toString() +
      " para conocer su ubicación actual.";
  var url = "https://wa.me/" + contactFinal + "/?text=" + message;
  if (await canLaunch(url))
    await launch(url);
  else
    throw "Could not launch $url";
}

Future pushCodeEmergency(rNum) {
  return firestore
      .collection('emergencia')
      .doc(rNum)
      .collection('User')
      .add({'Codigo Emergencia ': rNum, 'ID usuario': _user.firstName});
}

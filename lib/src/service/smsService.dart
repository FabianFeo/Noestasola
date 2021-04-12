import 'dart:async';

import 'package:NoEstasSola/src/service/emergecySharePreference.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
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
  pushCodeEmergency(rNum.toString());
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

Future pushCodeEmergency(String rNum) async {
  EmergencySharePreference emergencySharePreference =
      EmergencySharePreference();
  Timer(Duration(minutes: 10), () {
    emergencySharePreference.disableEmergency();
    firestore.collection('emergencia').doc(rNum).delete();
  });

  await emergencySharePreference.activatedEmergency();

  await firestore
      .collection('emergencia')
      .doc(rNum)
      .set({'Codigo Emergencia ': rNum, 'ID usuario': _user.firstName});

  Timer.periodic(Duration(seconds: 5), (timer) async {
    if (await emergencySharePreference.getEmergency()) {
      Position position = await Geolocator.getLastKnownPosition();
      await firestore
          .collection('emergencia')
          .doc(rNum)
          .collection("positions")
          .add({'lat': position.latitude, 'lng': position.longitude});
    }
  });
}

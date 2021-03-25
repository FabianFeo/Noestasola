import 'package:NoEstasSola/src/model/User.model.dart';
import 'package:NoEstasSola/src/model/viaje.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ViajesServiceCollection {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var uuid = Uuid();
  User user = User();
  Viaje viaje = Viaje();
  Future pushviaje() {
    viaje.date = DateTime.now().toIso8601String();
    viaje.uiid = uuid.v4();
    viaje.idCliente = user.userUuid;
    return firestore.collection('viajes').doc(viaje.uiid).set(viaje.toMap());
  }

  Stream<DocumentSnapshot> getCambiosViaje() {
    return firestore.collection('viajes').doc(viaje.uiid).snapshots();
  }
}

import 'package:NoEstasSola/src/model/User.model.dart';
import 'package:NoEstasSola/src/model/viaje.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ViajesServiceCollection {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var uuid = Uuid();
  User user = User();
  Viaje _viaje = Viaje();
  Future pushviaje(Map<String, dynamic> viaje) {
    viaje['date'] = DateTime.now().toIso8601String();
    viaje['uiid'] = uuid.v4();
    _viaje.uiid = viaje['uiid'];
    viaje['idCliente'] = user.userUuid;
    viaje['estado'] = "enEspera";
    return firestore.collection('viajes').doc(_viaje.uiid).set(viaje);
  }

  Stream<DocumentSnapshot> getCambiosViaje() {
    return firestore.collection('viajes').doc(_viaje.uiid).snapshots();
  }

  Stream<QuerySnapshot> getHistorialViaje() {
    return firestore
        .collection('viajes')
        .where('idCliente', isEqualTo: user.userUuid)
        .snapshots();
  }
}

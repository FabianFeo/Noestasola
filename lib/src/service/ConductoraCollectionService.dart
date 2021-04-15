
import 'package:NoEstasSola/src/model/User.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConductoraCollectionService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future pushUser() {
    User usuario = User();
    return firestore
        .collection('driver')
        .doc(usuario.userUuid)
        .set(usuario.toMap());
  }

  Future<DocumentSnapshot> getConductora(String phone) {
    return firestore.collection('driver').doc(phone).get();
  }
}

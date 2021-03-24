

import 'package:NoEstasSola/src/model/User.model.dart';
import 'package:NoEstasSola/src/service/usersharePreference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCollectionService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future pushUser() {
    User usuario = User();
    UserSharePreference userSharePreference =UserSharePreference();
    userSharePreference.saveUser();
    return firestore
        .collection('users')
        .doc(usuario.userUuid)
        .set(usuario.toMap());
  }

  Future<DocumentSnapshot> getUser(String uiid) {

    return firestore.collection('users').doc(uiid).get();
  }
}

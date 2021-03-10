import 'dart:convert';

import 'package:NoEstasSola/src/model/User.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserCollectionService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future pushUser() {
    User usuario=User();
    return firestore
        .collection('users')
        .doc(usuario.cedula)
        .set(usuario.toMap());
  }
}

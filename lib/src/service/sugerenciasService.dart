import 'package:cloud_firestore/cloud_firestore.dart';

class SugerenciasService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future pushSugerencia(String sugerencia) {
    return firestore.collection('sugerencias').add({'sugerencia': sugerencia});
  }
}

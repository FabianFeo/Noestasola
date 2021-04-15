import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<DocumentReference> addMessage(Map travel, String message) async {
    return firestore
        .collection('viajes')
        .doc(travel['idViaje'])
        .collection('chat')
        .add({
      'Time': DateTime.now().millisecondsSinceEpoch,
      'messageDriver': null,
      'messageUser': message
    });
  }

  Stream<QuerySnapshot> getMessageDriver(Map travel) {
    return firestore
        .collection('viajes')
        .doc(travel['idViaje'])
        .collection('chat')
        .orderBy('Time')
        .snapshots();
  }
}

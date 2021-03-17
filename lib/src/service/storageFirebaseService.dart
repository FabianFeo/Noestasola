import 'dart:io';

import 'package:NoEstasSola/src/model/User.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageFirebaseService {
  User _user = User();

  Future<void> uplodaImage(File file) async {
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('users/${_user.userUuid}/profileImage');
    await storageReference.putFile(file).then((task) async  {
       var lista=await task.storage.ref().getData();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_user.userUuid)
              .update({'profileImage':lista});
        });
  }
}

import 'dart:io';

import 'package:NoEstasSola/src/model/User.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageFirebaseService {
  User _user = User();

  Future<void> uplodaImage(File file) async {
    var storageReference = FirebaseStorage.instance
        .ref('users/${_user.userUuid}/')
        .child('profileImage');
    await storageReference.putFile(file).then((task) async  {
       var lista=await task.storage.ref('users/${_user.userUuid}/').child('profileImage').getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_user.userUuid)
              .update({'profileImage':lista});
        });
  }
}

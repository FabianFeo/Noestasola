import 'package:NoEstasSola/src/service/usersCollectionService.dart';
import 'package:NoEstasSola/src/view/DatosPersonal.dart';

import 'package:NoEstasSola/src/view/sing-in.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:NoEstasSola/src/model/User.model.dart' as user show User;

class AuthService {
  static final AuthService _authService = AuthService._internal();
  factory AuthService() {
    return _authService;
  }
  user.User usuario = user.User();
  AuthService._internal();
  AuthCredential _authCredential;
  String status;
  String actualCode;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future registerUser(String mobile, BuildContext context) async {
    usuario.phoneNumber = mobile;
    return await _auth.verifyPhoneNumber(
      
        phoneNumber: "+57 " + mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential auth) {
          status = 'Auto retrieving verification code';

          _authCredential = auth;

          _auth.signInWithCredential(auth).then((UserCredential value) {
            if (value.user != null) {
              status = 'Authentication successful';

              onAuthenticationSuccessful(context, value);
            } else {
              status = 'Invalid code/invalid authentication';
            }
          }).catchError((error) {
            status = 'Something has gone wrong, please try later';
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          status = '${authException.message}';

          print("Error message: " + status);
          if (authException.message.contains('not authorized'))
            status = 'Something has gone wrong, please try later';
          else if (authException.message.contains('Network'))
            status = 'Please check your internet connection and try again';
          else
            status = 'Something has gone wrong, please try later';
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          this.actualCode = verificationId;
          print('Code sent to $mobile');
          status = "\nEnter the code sent to " + mobile;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.actualCode = verificationId;
          status = "\nAuto retrieval time out";
        });

  }

  void signInWithPhoneNumber(String smsCode, BuildContext context) async {
    _authCredential = await PhoneAuthProvider.credential(
        verificationId: actualCode, smsCode: smsCode);
    _auth.signInWithCredential(_authCredential).catchError((error) {
      status = 'Something has gone wrong, please try later';
    }).then((UserCredential user) async {
      status = 'Authentication successful';
      usuario.userUuid = user.user.uid;
      onAuthenticationSuccessful(context, user);
    });
  }

  void onAuthenticationSuccessful(BuildContext context, UserCredential value) {
    UserCollectionService userCollectionService = UserCollectionService();
    userCollectionService.getUser(value.user.uid).then((value) async {
      Navigator.of(context).pop();
      if (!value.exists) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DatosPersonal()));
      } else {
        var cameras = await availableCameras();
        usuario.fromMap(value.data());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignIn(
                      cameraDescription: cameras.firstWhere(
                        (CameraDescription camera) =>
                            camera.lensDirection == CameraLensDirection.front,
                      ),
                    )));
      }
    });
  }
}

import 'package:NoEstasSola/src/model/User.model.dart';
import 'package:NoEstasSola/src/service/databaseService.dart';
import 'package:NoEstasSola/src/service/faceNetService.dart';
import 'package:NoEstasSola/src/service/usersCollectionService.dart';
import 'package:NoEstasSola/src/view/index.dart';
import 'package:flutter/material.dart';

class AuthActionButton extends StatefulWidget {
  AuthActionButton(
    this._initializeControllerFuture, {
    @required this.onPressed,
    @required this.isLogin,
  });
  final Future _initializeControllerFuture;
  final Function onPressed;
  final bool isLogin;

  @override
  _AuthActionButtonState createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  /// service injection
  final FaceNetService _faceNetService = FaceNetService();
  final DataBaseService _dataBaseService = DataBaseService();

  User predictedUser;

  Future saveCara(context) async {
    /// gets predicted data from facenet service (user face detected)
    List predictedData = _faceNetService.predictedData;

    /// creates a new user in the 'database'
    await _dataBaseService.saveData(predictedData);
    User user = User();
    user.facePatern = predictedData;

    /// resets the face stored in the face net sevice
    this._faceNetService.setPredictedData(null);
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Index()));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text('Sign up'),
      icon: Icon(Icons.camera_alt),
      // Provide an onPressed callback.
      onPressed: () async {
        try {
          // Ensure that the camera is initialized.
          await widget._initializeControllerFuture;
          // onShot event (takes the image and predict output)
          bool faceDetected = await widget.onPressed();

          if (faceDetected) {
            widget.isLogin
                ? loadFace(context)
                : saveCara(context).then((value) {
                    UserCollectionService userCollectionService =
                        new UserCollectionService();

                    userCollectionService.pushUser();
                  });
          }
        } catch (e) {
          // If an error occurs, log the error to the console.
          print(e);
        }
      },
    );
  }

  Future loadFace(context) async {
    /// gets predicted data from facenet service (user face detected)

    if (_faceNetService.predict()) {
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Index()));
    }
    
  }

  @override
  void dispose() {
    super.dispose();
  }
}

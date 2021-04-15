import 'package:NoEstasSola/src/model/User.model.dart';
import 'package:NoEstasSola/src/service/authService.dart';
import 'package:NoEstasSola/src/service/usersCollectionService.dart';
import 'package:NoEstasSola/src/service/usersharePreference.dart';
import 'package:NoEstasSola/src/view/sing-in.dart';
import 'package:NoEstasSola/src/view/usuarioLogin.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Carga extends StatefulWidget {
  Carga({Key key}) : super(key: key);

  @override
  _CargaState createState() => _CargaState();
}

class _CargaState extends State<Carga> {
  VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/carga.mp4')
      ..initialize().then((_) {
        Future.delayed(Duration(seconds: 4), () {
          AuthService authService = AuthService();
          authService.stateListen().listen((value) async {
            UserCollectionService userCollectionService =
                UserCollectionService();
            var user;
            if (value != null) {
              user = await userCollectionService.getUser(value.uid);
            }

            if (value == null || value.isAnonymous || !user.exists) {
               Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UsuarioLogin()));
            } else {
              UserSharePreference userSharePreference = UserSharePreference();
              userSharePreference.getUser().then((value) async {
                User user = User();
                print(user);
                var cameras = await availableCameras();
                 Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignIn(
                              cameraDescription: cameras.firstWhere(
                                (CameraDescription camera) =>
                                    camera.lensDirection ==
                                    CameraLensDirection.front,
                              ),
                            )));
              });
            }
          });
        });
        setState(() {});
      });
  }

  @override
  void reassemble() {
    super.reassemble();
    _controller = VideoPlayerController.asset('assets/video/carga.mp4')
      ..initialize().then((_) {
        Future.delayed(Duration(seconds: 4), () {
          AuthService authService = AuthService();
          authService.stateListen().listen((value) async {
            UserCollectionService userCollectionService =
                UserCollectionService();
            var user;
            if (value != null) {
              user = await userCollectionService.getUser(value.uid);
            }

            if (value == null || value.isAnonymous || !user.exists) {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UsuarioLogin()));
            } else {
              UserSharePreference userSharePreference = UserSharePreference();
              userSharePreference.getUser().then((value) async {
                User user = User();
                print(user);
                var cameras = await availableCameras();
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignIn(
                              cameraDescription: cameras.firstWhere(
                                (CameraDescription camera) =>
                                    camera.lensDirection ==
                                    CameraLensDirection.front,
                              ),
                            )));
              });
            }
          });
        });
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    _controller.play();
    return Container(
        color: Colors.black,
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )),
        ));
  }
}

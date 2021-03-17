import 'package:NoEstasSola/src/view/firstPage.dart';
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
        Future.delayed(
            Duration(seconds:4),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => FirstPage())));
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

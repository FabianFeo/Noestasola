import 'package:NoEstasSola/src/service/databaseService.dart';
import 'package:NoEstasSola/src/service/faceNetService.dart';
import 'package:NoEstasSola/src/service/mlVisionService.dart';
import 'package:NoEstasSola/src/view/firstPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  inicializar() async {
    
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp().then((value) async {
      inicializar();
      FaceNetService _faceNetService = FaceNetService();
      MLVisionService _mlVisionService = MLVisionService();
      await _faceNetService.loadModel();

    _mlVisionService.initialize();
    });
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstPage(),
    );
  }
}

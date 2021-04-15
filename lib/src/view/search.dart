import 'package:NoEstasSola/src/service/chatService.dart';
import 'package:NoEstasSola/src/service/databaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:NoEstasSola/src/model/User.model.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController =
      new TextEditingController();
  DataBaseService dataBaseService = new DataBaseService();

  bool isLoading = false;
  bool haveUserSearched = false;
  User _user = User();
  ChatService chatService = ChatService();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Busqueda"),
        backgroundColor: Color.fromRGBO(101, 79, 168, 1),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                        hintText: "Buscar conductora...",
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(101, 79, 168, 1)),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(Icons.search),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

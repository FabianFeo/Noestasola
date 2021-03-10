import 'package:flutter/cupertino.dart';

class User {
  static final User _user = User._internal();
  String phoneNumber;
  String firstName;
  String lastname;
  String email;
  String cedula;
  String userUuid;
  User._internal();
  factory User() {
    return _user;
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastname': lastname,
      'email': email,
      'cedula': cedula,
      'phoneNumber': phoneNumber,
      'userUuid':userUuid
    };
  }
}

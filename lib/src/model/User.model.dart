import 'package:flutter/cupertino.dart';

class User {
  static final User _user = User._internal();
  String phoneNumber;
  String firstName;
  String lastname;
  String email;
  String documento;
  String userUuid;
  String documentoType;
  String expeditionDate;

  User._internal();
  factory User() {
    return _user;
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastname': lastname,
      'email': email,
      'documento': documento,
      'phoneNumber': phoneNumber,
      'userUuid':userUuid,
      'documentoType':documentoType,
      'expeditionDate':expeditionDate
    };
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String email;
  String name;
  String phoneNo;
  String image;
  String gender;
  String uid;
  String pass;
  UserModel(
      {required this.uid,
      required this.gender,
      required this.email,
      required this.name,
      required this.pass,
      required this.phoneNo,
      required this.image});
  factory UserModel.fromJson(QueryDocumentSnapshot<Object?> json) => UserModel(
        name: json['name'],
        email: json['email'],
        gender: json['gender'],
        image: json['image'],
        phoneNo: json['phoneNo'],
        uid: json['uid'],
        pass: json['pass'],
      );

  Map<String, String> toJson() => {
        'name': name,
        'email': email,
        'gender': gender,
        'image': image,
        'phoneNo': phoneNo,
        'uid': uid,
        'pass': pass,
      };
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
 final String uid;
 final String phoneNumber;
 final String pinhash;
 final Timestamp createdAt;

UserModel({
 required this.uid, 
 required this.phoneNumber, 
 required this.pinhash, 
 required this.createdAt,
 });
 
  Map<String, dynamic> toJson() => {
    'uid': uid,
    'phoneNumber': phoneNumber,
    'pinhash': pinhash,
    'createdAt': createdAt,
  };

 factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        uid: json['uid'],
        phoneNumber: json['phoneNumber'],
        pinhash: json['pinhash'],
        createdAt: json['createdAt'],
      );}


}
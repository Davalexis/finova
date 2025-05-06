import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthRepository {
  // ignore: unused_field
  final _auth = FirebaseAuth.instance;

  Future<bool> checkIfUserExist(String phoneNumber) async{
    final userDoc = await FirebaseFirestore.instance
    .collection('users')
    .where('phone', isEqualTo: phoneNumber)
    .limit(1)
    .get();

    return userDoc.docs.isNotEmpty;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CreateAcctController extends StateNotifier<bool> {
  CreateAcctController(this.ref):super(false);
  final Ref ref;
Future<void> createAccountWithPin(
  BuildContext context,
  String phoneNumber,
  String pin,
) async {
  state = true;

  try {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      throw Exception("User not authenticated");
    }
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

    await userDoc.set({
      'phoneNumber': phoneNumber,
      'pin': pin,
      'createdAt': FieldValue.serverTimestamp(),
    });

    Navigator.pushReplacementNamed(context, 'ComfirmPinScreen');
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error:${e.toString()}')));
  } finally {
    state = false;
  }
}
}
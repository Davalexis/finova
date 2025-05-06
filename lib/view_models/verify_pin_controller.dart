import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyPinController extends StateNotifier<bool> {
  final Ref ref;
  VerifyPinController (this.ref) : super(false);

  final FirebaseAuth auth = FirebaseAuth.instance;

  // Existing signInWithPhone method...

  Future<void> verifyUserPin(
    BuildContext context,
    String phone,
    String enteredpin,
  ) async {
    state = true;
    try {
      final userSnap = await FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: phone)
          .limit(1)
          .get();

      if (userSnap.docs.isEmpty) {
        throw Exception('No user found');
      }

      final userData = userSnap.docs.first.data();
      final savedPin = userData['Pin'];

      if (savedPin == enteredpin) {
        Navigator.pushReplacementNamed(context, '/DashboardScreen');
      } else {
        throw Exception('Incorrect pin');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      state = false;
    }
  }
}

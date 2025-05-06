import 'package:finova/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<bool> {
  final Ref ref;
  AuthController(this.ref) : super(false);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signInWithPhone(String phoneNumber, BuildContext context) async {
    state = true;
    await _auth.verifyPhoneNumber(
      //
      phoneNumber: phoneNumber,

      //
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Navigator.pushReplacementNamed(context, '/CodeAuthScreen');
      },

      //
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An Error occured ${e.message}')),
        );
        state = false;
      },

      //
      codeSent: (String verificationId, int? resendToken) {
        ref.read(_verticationIdProvider.notifier).state = verificationId;
        Navigator.pushNamed(context, '/CodeAuthScreen');
      },

      //
      codeAutoRetrievalTimeout: (String verificationId) {
        ref.read(verificationIdProvider.notifier).state = verificationId;
        ref
            .read(authControllerProvider.notifier)
            .setVerificationId(verificationId);
      },
    );
  }
}

final _verticationIdProvider = StateProvider<String?>((ref) => null);
